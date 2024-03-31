{ lib }:
with lib.lists;
with lib.types;
with lib.attrsets;
with lib.strings; {
  doubleFromSystem = { cpu, kernel, abi, ... }:
    if abi == abis.cygnus then
      "${cpu.name}-cygwin"
    else if kernel.families ? darwin then
      "${cpu.name}-darwin"
    else
      "${cpu.name}-${kernelName kernel}";

  tripleFromSystem = { cpu, vendor, kernel, abi, ... }@sys:
    assert isSystem sys;
    let
      optExecFormat = lib.optionalString (kernel.name == "netbsd"
        && gnuNetBSDDefaultExecFormat cpu != kernel.execFormat)
        kernel.execFormat.name;
      optAbi = lib.optionalString (abi != abis.unknown) "-${abi.name}";
    in "${cpu.name}-${vendor.name}-${
      kernelName kernel
    }${optExecFormat}${optAbi}";

  mkSystemFromSkeleton = { cpu,
    # Optional, but fallback too complex for here.
    # Inferred below instead.
    vendor ? assert false; null, kernel,
    # Also inferred below
    abi ? assert false; null, }@args:
    let
      getCpu = name: cpuTypes.${name} or (throw "Unknown CPU type: ${name}");
      getVendor = name: vendors.${name} or (throw "Unknown vendor: ${name}");
      getKernel = name: kernels.${name} or (throw "Unknown kernel: ${name}");
      getAbi = name: abis.${name} or (throw "Unknown ABI: ${name}");

      parsed = {
        cpu = getCpu args.cpu;
        vendor = if args ? vendor then
          getVendor args.vendor
        else if isDarwin parsed then
          vendors.apple
        else if isWindows parsed then
          vendors.pc
        else
          vendors.unknown;
        kernel = if hasPrefix "darwin" args.kernel then
          getKernel "darwin"
        else if hasPrefix "netbsd" args.kernel then
          getKernel "netbsd"
        else
          getKernel args.kernel;
        abi = if args ? abi then
          getAbi args.abi
        else if isLinux parsed || isWindows parsed then
          if isAarch32 parsed then
            if lib.versionAtLeast (parsed.cpu.version or "0") "6" then
              abis.gnueabihf
            else
              abis.gnueabi
          else if isPower64 parsed && isBigEndian parsed then
            abis.gnuabielfv2
          else
            abis.gnu
        else
          abis.unknown;
      };
    in mkSystem parsed;

  mkSkeletonFromList = l:
    {
      "1" = if elemAt l 0 == "avr" then {
        cpu = elemAt l 0;
        kernel = "none";
        abi = "unknown";
      } else
        throw "Target specification with 1 components is ambiguous";
      "2" = # We only do 2-part hacks for things Nix already supports
        if elemAt l 1 == "cygwin" then {
          cpu = elemAt l 0;
          kernel = "windows";
          abi = "cygnus";
        } else if elemAt l 1 == "windows" then {
          cpu = elemAt l 0;
          kernel = "windows";
          abi = "msvc";
        } else if (elemAt l 1) == "elf" then {
          cpu = elemAt l 0;
          vendor = "unknown";
          kernel = "none";
          abi = elemAt l 1;
        } else {
          cpu = elemAt l 0;
          kernel = elemAt l 1;
        };
      "3" =
        # cpu-kernel-environment
        if elemAt l 1 == "linux"
        || elem (elemAt l 2) [ "eabi" "eabihf" "elf" "gnu" ] then {
          cpu = elemAt l 0;
          kernel = elemAt l 1;
          abi = elemAt l 2;
          vendor = "unknown";
        } else if elemAt l 1 == "apple"
        || elem (elemAt l 2) [ "wasi" "redox" "mmixware" "ghcjs" "mingw32" ]
        || hasPrefix "freebsd" (elemAt l 2) || hasPrefix "netbsd" (elemAt l 2)
        || hasPrefix "genode" (elemAt l 2) then {
          cpu = elemAt l 0;
          vendor = elemAt l 1;
          kernel = if elemAt l 2 == "mingw32" then
            "windows" # autotools breaks on -gnu for window
          else
            elemAt l 2;
        } else
          throw "Target specification with 3 components is ambiguous";
      "4" = {
        cpu = elemAt l 0;
        vendor = elemAt l 1;
        kernel = elemAt l 2;
        abi = elemAt l 3;
      };
    }.${toString (length l)} or (throw
      "system string has invalid number of hyphen-separated components");

  # GNU build systems assume that older NetBSD architectures are using a.out.
  gnuNetBSDDefaultExecFormat = cpu:
    if (cpu.family == "arm" && cpu.bits == 32)
    || (cpu.family == "sparc" && cpu.bits == 32)
    || (cpu.family == "m68k" && cpu.bits == 32)
    || (cpu.family == "x86" && cpu.bits == 32) then
      execFormats.aout
    else
      execFormats.elf;
}
