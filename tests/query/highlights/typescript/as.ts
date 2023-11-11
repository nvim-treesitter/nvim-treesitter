import * as foo from 'foo';
//       ^ @keyword.import

export { foo as bar };
//           ^ @keyword.import

const n = 5 as number;
//          ^ @keyword.operator
