# Do not edit this file - Generated by MiniPerl6 3.0
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;
{
package CompUnit;
sub new { shift; bless { @_ }, "CompUnit" }
sub name { @_ == 1 ? ( $_[0]->{name} ) : ( $_[0]->{name} = $_[1] ) };
sub attributes { @_ == 1 ? ( $_[0]->{attributes} ) : ( $_[0]->{attributes} = $_[1] ) };
sub methods { @_ == 1 ? ( $_[0]->{methods} ) : ( $_[0]->{methods} = $_[1] ) };
sub body { @_ == 1 ? ( $_[0]->{body} ) : ( $_[0]->{body} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; my $env; do {  ($env = $List__->[0]); [$env] }; do { for my $stmt ( @{$self->{body}} ) { $stmt->eval($env) } } }

}
{
package Val::Int;
sub new { shift; bless { @_ }, "Val::Int" }
sub int { @_ == 1 ? ( $_[0]->{int} ) : ( $_[0]->{int} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; $self->{int} }

}
{
package Val::Bit;
sub new { shift; bless { @_ }, "Val::Bit" }
sub bit { @_ == 1 ? ( $_[0]->{bit} ) : ( $_[0]->{bit} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; $self->{bit} }

}
{
package Val::Num;
sub new { shift; bless { @_ }, "Val::Num" }
sub num { @_ == 1 ? ( $_[0]->{num} ) : ( $_[0]->{num} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; $self->{num} }

}
{
package Val::Buf;
sub new { shift; bless { @_ }, "Val::Buf" }
sub buf { @_ == 1 ? ( $_[0]->{buf} ) : ( $_[0]->{buf} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; $self->{buf} }

}
{
package Val::Undef;
sub new { shift; bless { @_ }, "Val::Undef" }
sub eval { my $self = shift; my $List__ = \@_; do { [] }; (undef) }

}
{
package Val::Object;
sub new { shift; bless { @_ }, "Val::Object" }
sub class { @_ == 1 ? ( $_[0]->{class} ) : ( $_[0]->{class} = $_[1] ) };
sub fields { @_ == 1 ? ( $_[0]->{fields} ) : ( $_[0]->{fields} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: Val::Object'); 'bless(' . Main::perl($self->{fields}, ) . ', ' . Main::perl($self->{class}, ) . ')' }

}
{
package Lit::Seq;
sub new { shift; bless { @_ }, "Lit::Seq" }
sub seq { @_ == 1 ? ( $_[0]->{seq} ) : ( $_[0]->{seq} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: Lit::Seq'); '(' . Main::join([ map { $_->eval() } @{ $self->{seq} } ], ', ') . ')' }

}
{
package Lit::Array;
sub new { shift; bless { @_ }, "Lit::Array" }
sub array1 { @_ == 1 ? ( $_[0]->{array1} ) : ( $_[0]->{array1} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: Lit::Array'); '[' . Main::join([ map { $_->eval() } @{ $self->{array1} } ], ', ') . ']' }

}
{
package Lit::Hash;
sub new { shift; bless { @_ }, "Lit::Hash" }
sub hash1 { @_ == 1 ? ( $_[0]->{hash1} ) : ( $_[0]->{hash1} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: Lit::Hash'); (my  $fields = $self->{hash1}); (my  $str = ''); do { for my $field ( @{$fields} ) { ($str = $str . $field->[0]->eval() . ' => ' . $field->[1]->eval() . ',') } }; '{ ' . $str . ' }' }

}
{
package Lit::Code;
sub new { shift; bless { @_ }, "Lit::Code" }


}
{
package Lit::Object;
sub new { shift; bless { @_ }, "Lit::Object" }
sub class { @_ == 1 ? ( $_[0]->{class} ) : ( $_[0]->{class} = $_[1] ) };
sub fields { @_ == 1 ? ( $_[0]->{fields} ) : ( $_[0]->{fields} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: Lit::Object'); (my  $fields = $self->{fields}); (my  $str = ''); do { for my $field ( @{$fields} ) { ($str = $str . $field->[0]->eval() . ' => ' . $field->[1]->eval() . ',') } }; $self->{class} . '->new( ' . $str . ' )' }

}
{
package Index;
sub new { shift; bless { @_ }, "Index" }
sub obj { @_ == 1 ? ( $_[0]->{obj} ) : ( $_[0]->{obj} = $_[1] ) };
sub index_exp { @_ == 1 ? ( $_[0]->{index_exp} ) : ( $_[0]->{index_exp} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; $self->{obj}->eval()->[$self->{index_exp}->eval()] }

}
{
package Lookup;
sub new { shift; bless { @_ }, "Lookup" }
sub obj { @_ == 1 ? ( $_[0]->{obj} ) : ( $_[0]->{obj} = $_[1] ) };
sub index_exp { @_ == 1 ? ( $_[0]->{index_exp} ) : ( $_[0]->{index_exp} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; $self->{obj}->eval()->{$self->{index_exp}->eval()} }

}
{
package Var;
sub new { shift; bless { @_ }, "Var" }
sub sigil { @_ == 1 ? ( $_[0]->{sigil} ) : ( $_[0]->{sigil} = $_[1] ) };
sub twigil { @_ == 1 ? ( $_[0]->{twigil} ) : ( $_[0]->{twigil} = $_[1] ) };
sub namespace { @_ == 1 ? ( $_[0]->{namespace} ) : ( $_[0]->{namespace} = $_[1] ) };
sub name { @_ == 1 ? ( $_[0]->{name} ) : ( $_[0]->{name} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: Var'); (my  $table = { '$' => '$','@' => '$List_','%' => '$Hash_','&' => '$Code_', }); (my  $ns = ''); do { if ($self->{namespace}) { ($ns = $self->{namespace} . '::') } else { do { if ((($self->{sigil} eq '@') && (($self->{twigil} eq '*') && ($self->{name} eq 'ARGS')))) { return('(\\@ARGV)') } else {  } };do { if (($self->{twigil} eq '.')) { return('$self->{' . $self->{name} . '}') } else {  } };do { if (($self->{name} eq '/')) { return($table->{$self->{sigil}} . 'MATCH') } else {  } } } }; return($table->{$self->{sigil}} . $ns . $self->{name}) };
sub plain_name { my $self = shift; my $List__ = \@_; do { [] }; do { if ($self->{namespace}) { return($self->{namespace} . '::' . $self->{name}) } else {  } }; return($self->{name}) }

}
{
package Bind;
sub new { shift; bless { @_ }, "Bind" }
sub parameters { @_ == 1 ? ( $_[0]->{parameters} ) : ( $_[0]->{parameters} = $_[1] ) };
sub arguments { @_ == 1 ? ( $_[0]->{arguments} ) : ( $_[0]->{arguments} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: Bind'); do { if (Main::isa($self->{parameters}, 'Lit::Array')) { (my  $a = $self->{parameters}->array1());(my  $str = 'do { ');(my  $i = 0);do { for my $var ( @{$a} ) { (my  $bind = Bind->new( 'parameters' => $var,'arguments' => Index->new( 'obj' => $self->{arguments},'index_exp' => Val::Int->new( 'int' => $i, ), ), ));($str = $str . ' ' . $bind->eval() . '; ');($i = ($i + 1)) } };return($str . $self->{parameters}->eval() . ' }') } else {  } }; do { if (Main::isa($self->{parameters}, 'Lit::Hash')) { (my  $a = $self->{parameters}->hash1());(my  $b = $self->{arguments}->hash1());(my  $str = 'do { ');(my  $i = 0);my  $arg;do { for my $var ( @{$a} ) { ($arg = Val::Undef->new(  ));do { for my $var2 ( @{$b} ) { do { if (($var2->[0]->buf() eq $var->[0]->buf())) { ($arg = $var2->[1]) } else {  } } } };(my  $bind = Bind->new( 'parameters' => $var->[1],'arguments' => $arg, ));($str = $str . ' ' . $bind->eval() . '; ');($i = ($i + 1)) } };return($str . $self->{parameters}->eval() . ' }') } else {  } }; do { if (Main::isa($self->{parameters}, 'Lit::Object')) { (my  $class = $self->{parameters}->class());(my  $a = $self->{parameters}->fields());(my  $b = $self->{arguments});(my  $str = 'do { ');(my  $i = 0);my  $arg;do { for my $var ( @{$a} ) { (my  $bind = Bind->new( 'parameters' => $var->[1],'arguments' => Call->new( 'invocant' => $b,'method' => $var->[0]->buf(),'arguments' => [],'hyper' => 0, ), ));($str = $str . ' ' . $bind->eval() . '; ');($i = ($i + 1)) } };return($str . $self->{parameters}->eval() . ' }') } else {  } }; '(' . $self->{parameters}->eval() . ' = ' . $self->{arguments}->eval() . ')' }

}
{
package Proto;
sub new { shift; bless { @_ }, "Proto" }
sub name { @_ == 1 ? ( $_[0]->{name} ) : ( $_[0]->{name} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; ("" . $self->{name}) }

}
{
package Call;
sub new { shift; bless { @_ }, "Call" }
sub invocant { @_ == 1 ? ( $_[0]->{invocant} ) : ( $_[0]->{invocant} = $_[1] ) };
sub hyper { @_ == 1 ? ( $_[0]->{hyper} ) : ( $_[0]->{hyper} = $_[1] ) };
sub method { @_ == 1 ? ( $_[0]->{method} ) : ( $_[0]->{method} = $_[1] ) };
sub arguments { @_ == 1 ? ( $_[0]->{arguments} ) : ( $_[0]->{arguments} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: Call'); (my  $invocant = $self->{invocant}->eval()); do { if (($invocant eq 'self')) { ($invocant = '$self') } else {  } }; do { if ($self->{hyper}) {  } else {  } }; warn('Interpreter runtime error: method \'', $self->{method}, '()\' not found') }

}
{
package Apply;
sub new { shift; bless { @_ }, "Apply" }
sub code { @_ == 1 ? ( $_[0]->{code} ) : ( $_[0]->{code} = $_[1] ) };
sub arguments { @_ == 1 ? ( $_[0]->{arguments} ) : ( $_[0]->{arguments} = $_[1] ) };
sub namespace { @_ == 1 ? ( $_[0]->{namespace} ) : ( $_[0]->{namespace} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; my $env; do {  ($env = $List__->[0]); [$env] }; (my  $ns = ''); do { if ($self->{namespace}) { ($ns = $self->{namespace} . '::') } else {  } }; (my  $code = $ns . $self->{code}); do { for my $e ( @{$env} ) { do { if (exists($e->{$code})) { return($e->{$code})->eval($env, $self->{arguments}) } else {  } } } }; warn('Interpreter runtime error: subroutine \'', $code, '()\' not found') }

}
{
package Return;
sub new { shift; bless { @_ }, "Return" }
sub result { @_ == 1 ? ( $_[0]->{result} ) : ( $_[0]->{result} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: Return'); return('return(' . $self->{result}->eval() . ')') }

}
{
package If;
sub new { shift; bless { @_ }, "If" }
sub cond { @_ == 1 ? ( $_[0]->{cond} ) : ( $_[0]->{cond} = $_[1] ) };
sub body { @_ == 1 ? ( $_[0]->{body} ) : ( $_[0]->{body} = $_[1] ) };
sub otherwise { @_ == 1 ? ( $_[0]->{otherwise} ) : ( $_[0]->{otherwise} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: If'); (my  $cond = $self->{cond}); do { if ((Main::isa($cond, 'Apply') && ($cond->code() eq 'prefix:<!>'))) { (my  $if = If->new( 'cond' => $cond->arguments()->[0],'body' => $self->{otherwise},'otherwise' => $self->{body}, ));return($if->eval()) } else {  } }; do { if ((Main::isa($cond, 'Var') && ($cond->sigil() eq '@'))) { ($cond = Apply->new( 'code' => 'prefix:<@>','arguments' => [$cond], )) } else {  } }; 'do { if (' . $cond->eval() . ') { ' . Main::join([ map { $_->eval() } @{ $self->{body} } ], ';') . ' } else { ' . Main::join([ map { $_->eval() } @{ $self->{otherwise} } ], ';') . ' } }' }

}
{
package For;
sub new { shift; bless { @_ }, "For" }
sub cond { @_ == 1 ? ( $_[0]->{cond} ) : ( $_[0]->{cond} = $_[1] ) };
sub body { @_ == 1 ? ( $_[0]->{body} ) : ( $_[0]->{body} = $_[1] ) };
sub topic { @_ == 1 ? ( $_[0]->{topic} ) : ( $_[0]->{topic} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: For'); (my  $cond = $self->{cond}); do { if ((Main::isa($cond, 'Var') && ($cond->sigil() eq '@'))) { ($cond = Apply->new( 'code' => 'prefix:<@>','arguments' => [$cond], )) } else {  } }; 'do { for my ' . $self->{topic}->eval() . ' ( ' . $cond->eval() . ' ) { ' . Main::join([ map { $_->eval() } @{ $self->{body} } ], ';') . ' } }' }

}
{
package Decl;
sub new { shift; bless { @_ }, "Decl" }
sub decl { @_ == 1 ? ( $_[0]->{decl} ) : ( $_[0]->{decl} = $_[1] ) };
sub type { @_ == 1 ? ( $_[0]->{type} ) : ( $_[0]->{type} = $_[1] ) };
sub var { @_ == 1 ? ( $_[0]->{var} ) : ( $_[0]->{var} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: Decl'); (my  $decl = $self->{decl}); (my  $name = $self->{var}->plain_name()); (($decl eq 'has') ? 'sub ' . $name . ' { ' . '@_ == 1 ' . '? ( $_[0]->{' . $name . '} ) ' . ': ( $_[0]->{' . $name . '} = $_[1] ) ' . '}' : $self->{decl} . ' ' . $self->{type} . ' ' . $self->{var}->eval()) }

}
{
package Sig;
sub new { shift; bless { @_ }, "Sig" }
sub invocant { @_ == 1 ? ( $_[0]->{invocant} ) : ( $_[0]->{invocant} = $_[1] ) };
sub positional { @_ == 1 ? ( $_[0]->{positional} ) : ( $_[0]->{positional} = $_[1] ) };
sub named { @_ == 1 ? ( $_[0]->{named} ) : ( $_[0]->{named} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: Sig') }

}
{
package Method;
sub new { shift; bless { @_ }, "Method" }
sub name { @_ == 1 ? ( $_[0]->{name} ) : ( $_[0]->{name} = $_[1] ) };
sub sig { @_ == 1 ? ( $_[0]->{sig} ) : ( $_[0]->{sig} = $_[1] ) };
sub block { @_ == 1 ? ( $_[0]->{block} ) : ( $_[0]->{block} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: Method'); (my  $sig = $self->{sig}); (my  $invocant = $sig->invocant()); (my  $pos = $sig->positional()); (my  $str = 'my $List__ = \\@_; '); do { for my $field ( @{$pos} ) { do { if (Main::isa($field, 'Lit::Array')) { ($str = $str . 'my (' . Main::join([ map { $_->eval() } @{ $field->array1() } ], ', ') . '); ') } else { ($str = $str . 'my ' . $field->eval() . '; ') } } } }; (my  $bind = Bind->new( 'parameters' => Lit::Array->new( 'array1' => $sig->positional(), ),'arguments' => Var->new( 'sigil' => '@','twigil' => '','name' => '_', ), )); ($str = $str . $bind->eval() . '; '); 'sub ' . $self->{name} . ' { ' . 'my ' . $invocant->eval() . ' = shift; ' . $str . Main::join([ map { $_->eval() } @{ $self->{block} } ], '; ') . ' }' }

}
{
package Sub;
sub new { shift; bless { @_ }, "Sub" }
sub name { @_ == 1 ? ( $_[0]->{name} ) : ( $_[0]->{name} = $_[1] ) };
sub sig { @_ == 1 ? ( $_[0]->{sig} ) : ( $_[0]->{sig} = $_[1] ) };
sub block { @_ == 1 ? ( $_[0]->{block} ) : ( $_[0]->{block} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: Sub'); (my  $sig = $self->{sig}); (my  $pos = $sig->positional()); (my  $str = 'my $List__ = \\@_; '); do { for my $field ( @{$pos} ) { do { if (Main::isa($field, 'Lit::Array')) { ($str = $str . 'my (' . Main::join([ map { $_->eval() } @{ $field->array1() } ], ', ') . '); ') } else { ($str = $str . 'my ' . $field->eval() . '; ') } } } }; (my  $bind = Bind->new( 'parameters' => Lit::Array->new( 'array1' => $sig->positional(), ),'arguments' => Var->new( 'sigil' => '@','twigil' => '','name' => '_', ), )); ($str = $str . $bind->eval() . '; '); 'sub ' . $self->{name} . ' { ' . $str . Main::join([ map { $_->eval() } @{ $self->{block} } ], '; ') . ' }' }

}
{
package Do;
sub new { shift; bless { @_ }, "Do" }
sub block { @_ == 1 ? ( $_[0]->{block} ) : ( $_[0]->{block} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: Do'); 'do { ' . Main::join([ map { $_->eval() } @{ $self->{block} } ], '; ') . ' }' }

}
{
package Use;
sub new { shift; bless { @_ }, "Use" }
sub mod { @_ == 1 ? ( $_[0]->{mod} ) : ( $_[0]->{mod} = $_[1] ) };
sub eval { my $self = shift; my $List__ = \@_; do { [] }; warn('Interpreter TODO: Use'); 'use ' . $self->{mod} }

}
1;
