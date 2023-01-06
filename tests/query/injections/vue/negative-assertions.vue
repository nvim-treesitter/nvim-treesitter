<script lang="ts">
const foo: number = "1"
//          ^ !javascript
</script>
<style lang="scss">
.bar {
  &-baz {
    &.page{
//  ^ !css
    }
  }
}
</style>
