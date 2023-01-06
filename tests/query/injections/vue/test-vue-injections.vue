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
<!--              ^ javascript -->
</template>
<script> const foo = "1" </script>
<!--      ^ javascript -->
<script defer> const foo = "1" </script>
<!--              ^ javascript -->
<script lang="js"> const foo = "1" </script>
<!--                  ^ typescript -->
<script lang="ts"> const foo: number = "1" </script>
<!--                            ^ typescript -->
<!--                            ^ !javascript -->
<style> .bar { .foo{ } } </style>
<!--                ^ css   -->
<style scoped> .page.page--news { background: rebeccapurple; } </style>
<!--                ^ css  -->
<style lang="css"> .bar { justify-content: center; } </style>
<!--                ^ css  -->
<style lang="scss"> .bar { &-baz { } } </style>
<!--                       ^ scss -->
<!--                       ^ !css -->
