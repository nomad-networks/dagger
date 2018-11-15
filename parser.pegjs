{
	function Entity(label, value) {
    	this.label = label ;
        this.value = value ;
    	}
    
    Entity.prototype.toString = function() {
    	return String(this.value) ;
        }
}

ENTITY "Entity"
  = v:NUMBER {return new Entity(null, v)} 
  / l:LABEL v:NUMBER {return new Entity(l, v)}
  / v:STRING {return new Entity(null, v)}
  / l:LABEL v:STRING {return new Entity(l, v)}
  / THING
//  / expression

BEGIN_THING     = WS "{" WS
END_THING       = WS "}" WS
NAME_SEPARATOR  = WS ":" WS
VALUE_SEPARATOR = WS "," WS

WS "whitespace" = [ \t\n\r]*

// ----- Thing -----

THING "Thing"
  = BEGIN_THING
    values:(
      head:ENTITY
      tail:(VALUE_SEPARATOR v:ENTITY { return v; })*
      { return [head].concat(tail); }
    )?
    END_THING
    { return values !== null ? values : []; }


// ----- 6. Numbers -----

NUMBER "Number"
  = MINUS? INT FRAC? EXP? { return parseFloat(text()); }

DECIMAL_POINT "Decimal Point"
  = "."

DIGIT1_9
  = [1-9]

E
  = [eE]

EXP
  = E (MINUS / PLUS)? DIGIT+

FRAC
  = DECIMAL_POINT DIGIT+

INT
  = ZERO / (DIGIT1_9 DIGIT*)

MINUS
  = "-"

PLUS
  = "+"

ZERO
  = "0"

// ----- Strings -----

STRING "String"
  = QUOTATION_MARK chars:CHAR* QUOTATION_MARK { return chars.join(""); }

CHAR
  = UNESCAPED
  / ESCAPE
    sequence:(
        '"'
      / "\\"
      / "/"
      / "b" { return "\b"; }
      / "f" { return "\f"; }
      / "n" { return "\n"; }
      / "r" { return "\r"; }
      / "t" { return "\t"; }
      / "u" digits:$(HEXDIG HEXDIG HEXDIG HEXDIG) {
          return String.fromCharCode(parseInt(digits, 16));
        }
    )
    { return sequence; }

ESCAPE
  = "\\"

QUOTATION_MARK
  = '"'

UNESCAPED
  = [^\0-\x1F\x22\x5C]
  
// Labels

LABEL "Label"
  = v:IDENT ':' {return v;}
  
IDENT
  = $([a-z_]i[a-z0-9_]*)

// ----- Core ABNF Rules -----

// See RFC 4234, Appendix B (http://tools.ietf.org/html/rfc4234).
DIGIT  = [0-9]
HEXDIG = [0-9a-f]i
