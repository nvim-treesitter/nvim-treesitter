<template>
  <span>{{"Some text"}}</span>
  <!--      ^ javascript 
-->

  <template lang="pug">
    ul
      li(v-for="item in items")
        a(v-if="item.type == 'link'" :href="item.url") some link title: 
<!--                                                    ^ pug
-->
  </template>

  <template v-if="true"></template>
<!--              ^ javascript 
-->
</template>
<script>
const foo = "1"
//    ^ javascript
</script>
<script defer lang="js">
const foo = "1"
//    ^ javascript
</script>
<script lang="ts">
const foo = "1"
//    ^ typescript
</script>
<style>
.bar {
/* ^ css*/
}
</style>
<style lang="scss">
.bar {
  &-baz {
//  ^ scss
  }
}
</style>
