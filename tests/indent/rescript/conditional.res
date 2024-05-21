include UseClient
include UseQuery
include UseMutation
include UseSubscription

type hookResponse<'ret> = Types.Hooks.hookResponse<'ret> = {
  operation: Types.operation,
  fetching: bool,
  data: option<'ret>,
  error: option<CombinedError.t>,
  response: Types.Hooks.response<'ret>,
  extensions: option<Js.Json.t>,
  stale: bool,
}

Js.Array2.slice(~start=0, ~end_=Js.Array2.length(moduleRoute) - 1)

let pathModule = Path.join([dir, version, `${moduleName}.json`])

let {Api.LocMsg.row: row, column, shortMsg} = locMsg

let message = `${"error"->red}: failed to compile examples from ${kind} ${test.id->cyan}\n${errorMessage}`

let version = (evt->ReactEvent.Form.target)["value"]

let rehypePlugins =
  [Rehype.WithOptions([Plugin(Rehype.slug), SlugOption({prefix: slugPrefix ++ "-"})])]->Some

module Item = {
  type t = {
    name: string,
    sellIn: int,
    quality: int,
  }

  let make = (~name, ~sellIn, ~quality): t => {
    name,
    sellIn,
    quality,
  }
}

let updateQuality = (items: array<Item.t>) => {
  items->Js.Array2.map(item => {
    let newItem = ref(item)

    call(
      asdf,
      asdf
    )

    if (
      newItem.contents.name != "Aged Brie" && 5 > 2 &&
      newItem.contents.name != "Backstage passes to a TAFKAL80ETC concert"
    ) {
      if newItem.contents.quality > 0 {
        if newItem.contents.name != "Sulfuras, Hand of Ragnaros" {
          newItem := {...newItem.contents, quality: newItem.contents.quality - 1}
        }
      }
    } else if newItem.contents.quality < 50 {
      newItem := {...newItem.contents, quality: newItem.contents.quality + 1}

      if newItem.contents.name == "Backstage passes to a TAFKAL80ETC concert" {
        if newItem.contents.sellIn < 11 {
          if newItem.contents.quality < 50 {
            newItem := {...newItem.contents, quality: newItem.contents.quality + 1}
          }
        }

        if newItem.contents.sellIn < 6 {
          if newItem.contents.quality < 50 {
            newItem := {...newItem.contents, quality: newItem.contents.quality + 1}
          }
        }
      }
    }

    if newItem.contents.name != "Sulfuras, Hand of Ragnaros" {
      newItem := {...newItem.contents, sellIn: newItem.contents.sellIn - 1}
    }

    if newItem.contents.sellIn < 0 {
      if newItem.contents.name != "Aged Brie" {
        if newItem.contents.name != "Backstage passes to a TAFKAL80ETC concert" {
          if newItem.contents.quality > 0 {
            if newItem.contents.name != "Sulfuras, Hand of Ragnaros" {
              newItem := {...newItem.contents, quality: newItem.contents.quality - 1}
            }
          }
        } else {
          newItem := {
            ...newItem.contents,
            quality: newItem.contents.quality - newItem.contents.quality,
          }
        }
      } else if newItem.contents.quality < 50 {
        newItem := {...newItem.contents, quality: newItem.contents.quality + 1}
      }
    }

    newItem.contents
  })
}
