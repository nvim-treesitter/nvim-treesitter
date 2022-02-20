type StyledFunction = <P extends {}>(
  templates: TemplateStringsArray,
  ...functions: ((props: P) => any)[]
) => any;

type StyledFunctionWithAttrs = StyledFunction & {
  attrs: (props: any) => StyledFunction;
};

declare const css: StyledFunction;

declare const gql: (templates: TemplateStringsArray) => any;

declare const hbs: (templates: TemplateStringsArray) => any;

declare const styled: {
  [key in string]: StyledFunctionWithAttrs;
} & ((component: any) => StyledFunctionWithAttrs);

declare const Component: any;

declare const createGlobalStyle: StyledFunction;

// {lang}`<{lang}>`
const FlexCSS = css`display: flex`;
//                  ^ css

// gql`<graphql>`
const GraphQLSchema = gql`
  type Query {
""" ^ graphql """
    character(name: string): Character
  }

  type Character {
    name: string
    class: string
   }`;
// ^ graphql

// hbs`<glimmer>`
const glimmerTemplate = hbs`
  <h1>Hello World!</h1>
    `;
// ^ glimmer

// styled.div`<css>`
const StyledDiv = styled.div<{ isMobile?: boolean }>`
  width: 100%;
/* ^ css */
  margin: ${({ isMobile }) => (isMobile ? "2px" : "4px")};
/*                                                       ^ css */
`;

// styled(Component)`<css>`
const StyledComponent = styled(Component)<{
  isFixed?: boolean;
  margin: number | string;
}>`
  width: 100%;
/* ^ css */
  margin: ${({ margin }) => margin};
/*                                 ^ css */
  ${({ isFixed }) => isFixed && css`position: fixed;`}
/*                                  ^ css */
    `;
/* ^ css */

// styled.div.attrs({ prop: "foo" })`<css>`
const StyledDivWithRef = styled.div.attrs({ ref: {} })<{ isMobile?: boolean }>`
  width: 100%;
/* ^ css */
  margin: ${({ isMobile }) => (isMobile ? "2px" : "4px")};
/*                                                       ^ css */
`;

// styled(Component).attrs({ prop: "foo" })`<css>`
const StyledComponentWithProp = styled(Component).attrs({ prop: true })<{
  isFixed?: boolean;
  margin: number | string;
}>`
  width: 100%;
/* ^ css */
  margin: ${({ margin }) => margin};
  ${({ isFixed }) => isFixed && css`position: fixed;`}
/*                                  ^ css */
`;

// createGlobalStyle`<css>`
const GlobalStyles = createGlobalStyle`
  @keyframes slideDown {
/* ^ css */
    from {transform: translateY(-200%)}
    to {transform: translateY(0)}
  }
`;
