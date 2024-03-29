// From https://docs.hhvm.com/hack/XHP/introduction (MIT licensed)

use namespace Facebook\XHP\Core as x;
use type Facebook\XHP\HTML\{XHPHTMLHelpers, a, form};


final xhp class a_post extends x\element {
// ^ @keyword.modifier
//     ^ @keyword.modifier
//                        ^ @keyword
  use XHPHTMLHelpers;

  attribute string href @required;
  //                      ^ @attribute
  attribute string target;
  // ^ @keyword

  <<__Override>>
  protected async function renderAsync(): Awaitable<x\node> {
    $id = $this->getID();

    $anchor = <a>{$this->getChildren()}</a>;
                                    // ^ @tag.delimiter
                                    // ^ @tag
    $form = (
      <form
        id={$id}
        method="post"
        action={$this->:href}
        target={$this->:target}
        class="postLink">
        {$anchor}
      </form>
    );

    $anchor->setAttribute(
      'onclick',
      'document.getElementById("'.$id.'").submit(); return false;',
    );
    $anchor->setAttribute('href', '#');
    //        ^ @function.method.call

    return $form;
  }
}

