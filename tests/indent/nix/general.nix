{ lib }:
with lib.lists;
with lib.types;
with lib.attrsets;
with lib.strings;
with (import ./inspect.nix { inherit lib; }).predicates;

let
  inherit (lib.options) mergeOneOption;

  setTypes = type:
    mapAttrs (name: value:
      assert type.check value;
      setType type.name ({ inherit name; } // value));

in rec {

  ################################################################################

  types.openSignificantByte = mkOptionType {
    name = "significant-byte";
    description = "Endianness";
    merge = mergeOneOption;
  };

  types.significantByte = enum (attrValues significantBytes);

  significantBytes = setTypes types.openSignificantByte {
    bigEndian = { };
    littleEndian = { };
  };

  ################################################################################

  # Reasonable power of 2
  types.bitWidth = enum [ 8 16 32 64 128 ];

  ################################################################################

  types.openCpuType = mkOptionType {
    name = "cpu-type";
    description = "instruction set architecture name and information";
    merge = mergeOneOption;
    check = x:
      types.bitWidth.check x.bits && (if 8 < x.bits then
        types.significantByte.check x.significantByte
      else
        !(x ? significantByte));
  };

  types.cpuType = enum (attrValues cpuTypes);

  cpuTypes = with significantBytes;
    setTypes types.openCpuType {
      arm = {
        bits = 32;
        significantByte = littleEndian;
        family = "arm";
      };
      armv5tel = {
        bits = 32;
        significantByte = littleEndian;
        family = "arm";
        version = "5";
        arch = "armv5t";
      };
    };

  isCompatible = a: b:
    with cpuTypes;
    lib.any lib.id [
      # x86
      (b == i386 && isCompatible a i486)
      (b == i486 && isCompatible a i586)
      (b == i586 && isCompatible a i686)

      # ARMv6
      (b == armv6l && isCompatible a armv6m)
      (b == armv6m && isCompatible a armv7l)
    ];

  ################################################################################

  types.openVendor = mkOptionType {
    name = "vendor";
    description = "vendor for the platform";
    merge = mergeOneOption;
  };

  abis = setTypes types.openAbi {
    cygnus = { };
    msvc = { };

    # Other architectures should use ELF in embedded situations.
    elf = { };

    androideabi = { };
    android = {
      assertions = [{
        assertion = platform: !platform.isAarch32;
        message = ''
          The "android" ABI is not for 32-bit ARM. Use "androideabi" instead.
        '';
      }];
    };
  };

  ################################################################################

  types.parsedPlatform = mkOptionType {
    name = "system";
    description =
      "fully parsed representation of llvm- or nix-style platform tuple";
    merge = mergeOneOption;
    check = { cpu, vendor, kernel, abi, }:
      types.cpuType.check cpu && types.vendor.check vendor
      && types.kernel.check kernel && types.abi.check abi;
  };

  isSystem = isType "system";

  mkSystem = components:
    assert types.parsedPlatform.check components;
    setType "system" components;

  mkSystemFromString = s:
    mkSystemFromSkeleton (mkSkeletonFromList (lib.splitString "-" s));

  ################################################################################
}
