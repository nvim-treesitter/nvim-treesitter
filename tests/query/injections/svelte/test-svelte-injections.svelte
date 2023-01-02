<script>
	import Button from "./Button.svelte";
//              ^ javascript
</script>
<script lang="ts">
  const foo: number = 1
//            ^ typescript
</script>

<style>
  main {
    font-family: sans-serif;
    text-align: center;
/*           ^ css
*/
  }
</style>
<style lang="scss">
  main {
    font-family: sans-serif;
    text-align: center;
    &:hover {
//  ^ scss
    }
  }
</style>

<main>
	<h1>Test file</h1>
  {#each someItems as someItem}
<!--          ^ javascript
-->
    <div>{someItem}</div>
<!--         ^ javascript 
-->
  {/each}
	<Button />
  <button on:click={() => foo++}></button>
</main>
