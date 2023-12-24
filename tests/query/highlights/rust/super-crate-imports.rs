use crate::a;
//  ^ @module
//  ^ !keyword
use crate::{b, c};
//  ^ @module
//  ^ !keyword
use super::a;
//  ^ @module
//  ^ !keyword
use super::{b, c};
//  ^ @module
//  ^ !keyword
