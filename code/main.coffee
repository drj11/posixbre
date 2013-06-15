#!/usr/bin/env coffee

asRegExp = (pattern) ->
  # Convert single BRE token into JavaScript RegExp.
  # A string is returned.
  bre1token = (tok) ->
    # In POSIX RE in a bracket expression \ matches itself.
    if /^\[/.test tok
      tok = tok.replace /\\/, '\\\\'
    # In POSIX RE in a bracket expression an initial ]
    # or initial ^] is allowed.
    if /^\[\^?\]/.test tok
      return tok.replace /]/, '\\]'
    # Tokens for which we have to remove a leading backslash.
    if /^\\[(){}]$/.test tok
      return tok[1]
    # Tokens for which we have to add a leading backslash.
    if /^[+?|(){}]$/.test tok
      return '\\' + tok
    # Everything else is unchanged.
    return tok

  return pattern.replace ///
      \[\^?\]?[^]]*\] # Bracket Expression
    | \\.             # Backslash something
    | .               # Everything else
    ///g, bre1token

exports.asRegExp = asRegExp
