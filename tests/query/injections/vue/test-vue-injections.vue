<template>
  <span>{{"Text inside interpolation"}}</span>
  <!--      ^ javascript 
-->

  <template lang="pug">
    ul
      li(v-for="item in items")
        a(v-if="item.type == 'link'" :href="item.url") some link title in pug: 
<!--                                                    ^ pug
-->
  </template>

  <template v-if="'text inside directives'"></template>
<!--              ^ javascript 
-->
</template>
<script>
const foo = "1"
//    ^ javascript
</script>
<script defer>
const foo = "1"
//    ^ javascript
</script>
<script lang="js">
const foo = "1"
//    ^ javascript
</script>
<script lang="ts">
const foo: number = "1"
//          ^ typescript
</script>
<style>
.bar {
/* ^ css  
*/
}
</style>
<style scoped>
.page.page--news {
  padding: calc(var(--header-height)) 1rem 0 1rem;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100vw;
  min-height: calc(var(--vh, 1vh) * 100 - var(--header-height));
  background: rebeccapurple;
/*              ^ css 
*/
}
</style>
<style lang="css">
.bar {
  justify-content: center;
/*         ^ css
*/
}
</style>
<style lang="scss">
.bar {
  &-baz {
    &.page{
//  ^ scss
    }
  }
}
</style>
