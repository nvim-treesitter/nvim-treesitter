% include "data.dzn";
% ^^^^^^^ @keyword.directive
%         ^^^^^^^^^^ @string
%                   ^ @punctuation.delimiter

var 1..10: x;
% ^^^ @keyword
%   ^ @number
%    ^^ @operator
%      ^^ @number
%        ^ @punctuation.delimiter
%          ^ @variable
%           ^ @punctuation.delimiter
