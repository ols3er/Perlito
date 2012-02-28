# Do not edit this file - Generated by Perlito5 8.0
use v5;
use utf8;
use strict;
use warnings;
no warnings ('redefine', 'once', 'void', 'uninitialized', 'misc', 'recursion');
use Perlito5::Perl5::Runtime;
our $MATCH = Perlito5::Match->new();
package main;
use v5;
use Perlito5::AST;
package Javascript;
(do {
    sub tab {
        ((my  $level) = shift());
        ((chr(9)) x $level)
    };
    ((my  %safe_char) = ((chr(36) => 1), (chr(37) => 1), (chr(64) => 1), (chr(38) => 1), ('_' => 1), (',' => 1), ('.' => 1), (':' => 1), (chr(59) => 1), ('-' => 1), ('+' => 1), ('*' => 1), (' ' => 1), ('(' => 1), (')' => 1), ('<' => 1), (chr(61) => 1), ('>' => 1), ('[' => 1), (']' => 1), (chr(123) => 1), (chr(124) => 1), (chr(125) => 1)));
    sub escape_string {
        ((my  $s) = shift());
        (my  @out);
        ((my  $tmp) = '');
        if (($s eq '')) {
            return ((chr(39) . chr(39)))
        };
        for my $i ((0 .. (length($s) - 1))) {
            ((my  $c) = substr($s, $i, 1));
            if (((((((($c ge 'a') && ($c le 'z'))) || ((($c ge 'A') && ($c le 'Z')))) || ((($c ge '0') && ($c le '9')))) || exists($safe_char{$c})))) {
                ($tmp = ($tmp . $c))
            }
            else {
                if (($tmp ne '')) {
                    push(@out, (chr(39) . $tmp . chr(39)) )
                };
                push(@out, ('String.fromCharCode(' . ord($c) . (')')) );
                ($tmp = '')
            }
        };
        if (($tmp ne '')) {
            push(@out, (chr(39) . $tmp . chr(39)) )
        };
        return (join(' + ', @out))
    };
    sub to_str {
        ((my  $cond) = shift());
        if (($cond->isa('Val::Buf'))) {
            return ($cond->emit_javascript())
        }
        else {
            return (('string(' . $cond->emit_javascript() . ')'))
        }
    };
    sub to_num {
        ((my  $cond) = shift());
        if ((($cond->isa('Val::Int') || $cond->isa('Val::Num')))) {
            return ($cond->emit_javascript())
        }
        else {
            return (('num(' . $cond->emit_javascript() . ')'))
        }
    };
    sub to_bool {
        ((my  $cond) = shift());
        if ((((($cond->isa('Val::Int')) || ($cond->isa('Val::Num'))) || (($cond->isa('Apply') && ($cond->code() eq 'prefix:<' . chr(33) . '>')))))) {
            return ($cond->emit_javascript())
        }
        else {
            return (('bool(' . $cond->emit_javascript() . ')'))
        }
    };
    sub preprocess_array_interpolation {
        (my  @items);
        for my $item (@{$_[0]}) {
            if ((($item->isa('Apply') && ((($item->code() eq 'circumfix:<( )>') || ($item->code() eq 'list:<,>')))))) {
                for my $arg (@{preprocess_array_interpolation($item->arguments())}) {
                    push(@items, $arg )
                }
            }
            else {
                if ((($item->isa('Apply') && ($item->code() eq 'infix:<' . chr(61) . '>>')))) {
                    push(@items, $item->arguments()->[0] );
                    push(@items, $item->arguments()->[1] )
                }
                else {
                    push(@items, $item )
                }
            }
        };
        return (\@items)
    }
});
package Perlito5::Javascript::LexicalBlock;
(do {
    sub new {
        ((my  $class) = shift());
        bless({    @_}, $class)
    };
    sub block {
        $_[0]->{'block'}
    };
    sub needs_return {
        $_[0]->{'needs_return'}
    };
    sub top_level {
        $_[0]->{'top_level'}
    };
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        if (($self->{('top_level')})) {
            ((my  $block) = Perlito5::Javascript::LexicalBlock->new(('block' => $self->block()), ('needs_return' => $self->needs_return()), ('top_level' => 0)));
            return ((Javascript::tab($level) . 'try ' . chr(123) . (chr(10)) . $block->emit_javascript_indented(($level + 1)) . chr(59) . (chr(10)) . Javascript::tab($level) . chr(125) . (chr(10)) . Javascript::tab($level) . 'catch(err) ' . chr(123) . (chr(10)) . Javascript::tab(($level + 1)) . 'if ( err instanceof Error ) ' . chr(123) . (chr(10)) . Javascript::tab(($level + 2)) . 'throw(err)' . chr(59) . (chr(10)) . Javascript::tab(($level + 1)) . chr(125) . (chr(10)) . Javascript::tab(($level + 1)) . 'else ' . chr(123) . (chr(10)) . Javascript::tab(($level + 2)) . 'return(err)' . chr(59) . (chr(10)) . Javascript::tab(($level + 1)) . chr(125) . (chr(10)) . Javascript::tab($level) . chr(125)))
        };
        (my  @block);
        for ((@{$self->{('block')}})) {
            if ((defined($_))) {
                push(@block, $_ )
            }
        };
        if ((!(@block))) {
            return ((Javascript::tab($level) . 'null' . chr(59)))
        };
        (my  @str);
        for my $decl (@block) {
            if ((($decl->isa('Decl') && ($decl->decl() eq 'my')))) {
                push(@str, (Javascript::tab($level) . $decl->emit_javascript_init()) )
            };
            if ((($decl->isa('Apply') && ($decl->code() eq 'infix:<' . chr(61) . '>')))) {
                ((my  $var) = $decl->arguments()->[0]);
                if ((($var->isa('Decl') && ($var->decl() eq 'my')))) {
                    push(@str, (Javascript::tab($level) . $var->emit_javascript_init()) )
                }
            }
        };
        (my  $last_statement);
        if (($self->{('needs_return')})) {
            ($last_statement = pop(@block))
        };
        for my $decl (@block) {
            if ((!((($decl->isa('Decl') && ($decl->decl() eq 'my')))))) {
                push(@str, ($decl->emit_javascript_indented($level) . chr(59)) )
            }
        };
        if ((($self->{('needs_return')} && $last_statement))) {
            if (($last_statement->isa('If'))) {
                ((my  $cond) = $last_statement->cond());
                ((my  $body) = $last_statement->body());
                ((my  $otherwise) = $last_statement->otherwise());
                if ((($cond->isa('Var') && ($cond->sigil() eq chr(64))))) {
                    ($cond = Apply->new(('code' => 'prefix:<' . chr(64) . '>'), ('arguments' => [    $cond])))
                };
                ($body = Perlito5::Javascript::LexicalBlock->new(('block' => $body->stmts()), ('needs_return' => 1)));
                push(@str, (Javascript::tab($level) . 'if ( ' . Javascript::to_bool($cond) . ' ) ' . chr(123) . ' return (function () ' . chr(123) . (chr(10)) . $body->emit_javascript_indented(($level + 1)) . (chr(10)) . Javascript::tab($level) . chr(125) . ')()' . chr(59) . ' ' . chr(125)) );
                if (($otherwise)) {
                    ($otherwise = Perlito5::Javascript::LexicalBlock->new(('block' => $otherwise->stmts()), ('needs_return' => 1)));
                    push(@str, (Javascript::tab($level) . 'else ' . chr(123) . ' return (function () ' . chr(123) . (chr(10)) . $otherwise->emit_javascript_indented(($level + 1)) . (chr(10)) . Javascript::tab($level) . chr(125) . ')()' . chr(59) . ' ' . chr(125)) )
                }
            }
            else {
                if (((($last_statement->isa('Apply') && ($last_statement->code() eq 'return')) || $last_statement->isa('For')) || $last_statement->isa('While'))) {
                    push(@str, $last_statement->emit_javascript_indented($level) )
                }
                else {
                    push(@str, (Javascript::tab($level) . 'return(' . $last_statement->emit_javascript() . ')') )
                }
            }
        };
        return ((join((chr(10)), @str) . chr(59)))
    }
});
package CompUnit;
(do {
    sub emit_javascript {
        ((my  $self) = $_[0]);
        $self->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = $_[0]);
        ((my  $level) = $_[1]);
        (my  @body);
        ((my  $i) = 0);
        for ( ; (($i <= scalar(@{$self->{('body')}})));  ) {
            ((my  $stmt) = $self->{('body')}->[$i]);
            if ((((ref($stmt) eq 'Apply') && ($stmt->code() eq 'package')))) {
                ((my  $name) = $stmt->namespace());
                (my  @stmts);
                ($i)++;
                for ( ; ((($i <= scalar(@{$self->{('body')}})) && !((((ref($self->{('body')}->[$i]) eq 'Apply') && ($self->{('body')}->[$i]->code() eq 'package'))))));  ) {
                    push(@stmts, $self->{('body')}->[$i] );
                    ($i)++
                };
                push(@body, CompUnit->new(('name' => $name), ('body' => \@stmts)) )
            }
            else {
                if (defined($stmt)) {
                    push(@body, $stmt )
                };
                ($i)++
            }
        };
        ((my  $class_name) = $self->{('name')});
        ((my  $str) = ('make_package(' . chr(34) . $class_name . chr(34) . ')' . chr(59) . (chr(10)) . '(function () ' . chr(123) . (chr(10)) . '  var __PACKAGE__ ' . chr(61) . ' ' . chr(34) . $class_name . chr(34) . chr(59) . (chr(10)) . '  var PKG ' . chr(61) . ' NAMESPACE[__PACKAGE__]' . chr(59) . (chr(10))));
        for my $decl (@body) {
            if ((($decl->isa('Decl') && (($decl->decl() eq 'my'))))) {
                ($str = ($str . '  ' . $decl->emit_javascript_init()))
            };
            if ((($decl->isa('Apply') && ($decl->code() eq 'infix:<' . chr(61) . '>')))) {
                ((my  $var) = $decl->arguments()->[0]);
                if ((($var->isa('Decl') && ($var->decl() eq 'my')))) {
                    ($str = ($str . '  ' . $var->emit_javascript_init()))
                }
            }
        };
        for my $decl (@body) {
            if (($decl->isa('Sub'))) {
                ($str = ($str . ($decl)->emit_javascript_indented(($level + 1)) . (chr(59) . chr(10))))
            }
        };
        for my $decl (@body) {
            if ((((defined($decl) && (!((($decl->isa('Decl') && ($decl->decl() eq 'my')))))) && (!(($decl->isa('Sub'))))))) {
                ($str = ($str . ($decl)->emit_javascript_indented(($level + 1)) . (chr(59) . chr(10))))
            }
        };
        ($str = ($str . chr(125) . ')()' . (chr(10))))
    };
    sub emit_javascript_program {
        ((my  $comp_units) = shift());
        ((my  $str) = '');
        for my $comp_unit (@{$comp_units}) {
            ($str = ($str . $comp_unit->emit_javascript() . (chr(10))))
        };
        return ($str)
    }
});
package Val::Int;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        (Javascript::tab($level) . $self->{('int')})
    }
});
package Val::Num;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        (Javascript::tab($level) . $self->{('num')})
    }
});
package Val::Buf;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        (Javascript::tab($level) . Javascript::escape_string($self->{('buf')}))
    }
});
package Lit::Block;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $sig) = 'v__');
        if (($self->{('sig')})) {
            ($sig = $self->{('sig')}->emit_javascript_indented(($level + 1)))
        };
        return ((Javascript::tab($level) . ('(function (' . $sig . ') ' . chr(123) . chr(10)) . (Perlito5::Javascript::LexicalBlock->new(('block' => $self->{('stmts')}), ('needs_return' => 1)))->emit_javascript_indented(($level + 1)) . (chr(10)) . Javascript::tab($level) . chr(125) . ')'))
    }
});
package Lit::Array;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $items) = Javascript::preprocess_array_interpolation($self->{('array1')}));
        (Javascript::tab($level) . '(new ArrayRef(interpolate_array(' . join(', ', map($_->emit_javascript(), @{$items})) . ')))')
    }
});
package Lit::Hash;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $items) = Javascript::preprocess_array_interpolation($self->{('hash1')}));
        (Javascript::tab($level) . '(new HashRef(array_to_hash(interpolate_array(' . join(', ', map($_->emit_javascript(), @{$items})) . '))))')
    }
});
package Index;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        if ((($self->{('obj')}->isa('Var') && ($self->{('obj')}->sigil() eq chr(36))))) {
            ((my  $v) = Var->new(('sigil' => chr(64)), ('namespace' => $self->{('obj')}->namespace()), ('name' => $self->{('obj')}->name())));
            return (($v->emit_javascript_indented($level) . '[' . $self->{('index_exp')}->emit_javascript() . ']'))
        };
        (Javascript::tab($level) . '(' . $self->{('obj')}->emit_javascript() . ' ' . chr(63) . ' ' . $self->{('obj')}->emit_javascript() . ' : ' . $self->{('obj')}->emit_javascript() . ' ' . chr(61) . ' new ArrayRef([])' . ')._array_[' . $self->{('index_exp')}->emit_javascript() . ']')
    }
});
package Lookup;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        if ((($self->{('obj')}->isa('Var') && ($self->{('obj')}->sigil() eq chr(36))))) {
            ((my  $v) = Var->new(('sigil' => chr(37)), ('namespace' => $self->{('obj')}->namespace()), ('name' => $self->{('obj')}->name())));
            return (($v->emit_javascript_indented($level) . '[' . $self->{('index_exp')}->emit_javascript() . ']'))
        };
        (Javascript::tab($level) . '(' . $self->{('obj')}->emit_javascript() . ' ' . chr(63) . ' ' . $self->{('obj')}->emit_javascript() . ' : ' . $self->{('obj')}->emit_javascript() . ' ' . chr(61) . ' new HashRef(' . chr(123) . chr(125) . ')' . ')._hash_[' . $self->{('index_exp')}->emit_javascript() . ']')
    }
});
package Var;
(do {
    ((my  $table) = {    (chr(36) => 'v_'),
    (chr(64) => 'List_'),
    (chr(37) => 'Hash_'),
    (chr(38) => 'Code_')});
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        if ((($self->{('sigil')} eq '*'))) {
            ((my  $ns) = 'PKG');
            if (($self->{('namespace')})) {
                ($ns = ('NAMESPACE[' . chr(34) . $self->{('namespace')} . chr(34) . ']'))
            };
            return (($ns . '[' . chr(34) . $self->{('name')} . chr(34) . ']'))
        };
        ((my  $ns) = '');
        if (($self->{('namespace')})) {
            ($ns = ('NAMESPACE[' . chr(34) . $self->{('namespace')} . chr(34) . '].'))
        };
        ($ns . $table->{$self->{('sigil')}} . $self->{('name')})
    };
    sub plain_name {
        ((my  $self) = shift());
        if (($self->namespace())) {
            return (($self->namespace() . '.' . $self->name()))
        };
        return ($self->name())
    }
});
package Proto;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        (Javascript::tab($level) . 'CLASS[' . chr(34) . $self->{('name')} . chr(34) . ']')
    }
});
package Call;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $invocant) = $self->{('invocant')}->emit_javascript());
        ((my  $meth) = $self->{('method')});
        if ((($meth eq 'postcircumfix:<[ ]>'))) {
            return ((Javascript::tab($level) . '(' . $invocant . ' ' . chr(63) . ' ' . $invocant . ' : ' . $invocant . ' ' . chr(61) . ' new ArrayRef([])' . ')._array_[' . $self->{('arguments')}->emit_javascript() . ']'))
        };
        if ((($meth eq 'postcircumfix:<' . chr(123) . ' ' . chr(125) . '>'))) {
            return ((Javascript::tab($level) . '(' . $invocant . ' ' . chr(63) . ' ' . $invocant . ' : ' . $invocant . ' ' . chr(61) . ' new HashRef(' . chr(123) . chr(125) . ')' . ')._hash_[' . $self->{('arguments')}->emit_javascript() . ']'))
        };
        if ((($meth eq 'postcircumfix:<( )>'))) {
            ((my  @args) = ());
            for (@{$self->{('arguments')}}) {
                push(@args, $_->emit_javascript() )
            };
            return ((Javascript::tab($level) . '(' . $invocant . ')(' . join(',', @args) . ')'))
        };
        ((my  @args) = ($invocant));
        for (@{$self->{('arguments')}}) {
            push(@args, $_->emit_javascript() )
        };
        return ((Javascript::tab($level) . $invocant . '._class_.' . $meth . '(' . join(',', @args) . ')'))
    }
});
package Apply;
(do {
    ((my  %op_infix_js) = (('infix:<->' => ' - '), ('infix:<*>' => ' * '), ('infix:<' . chr(47) . '>' => ' ' . chr(47) . ' '), ('infix:<>>' => ' > '), ('infix:<<>' => ' < '), ('infix:<>' . chr(61) . '>' => ' >' . chr(61) . ' '), ('infix:<<' . chr(61) . '>' => ' <' . chr(61) . ' '), ('infix:<eq>' => ' ' . chr(61) . chr(61) . ' '), ('infix:<ne>' => ' ' . chr(33) . chr(61) . ' '), ('infix:<le>' => ' <' . chr(61) . ' '), ('infix:<ge>' => ' >' . chr(61) . ' '), ('infix:<' . chr(61) . chr(61) . '>' => ' ' . chr(61) . chr(61) . ' '), ('infix:<' . chr(33) . chr(61) . '>' => ' ' . chr(33) . chr(61) . ' ')));
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $apply) = $self->op_assign());
        if (($apply)) {
            return ($apply->emit_javascript_indented($level))
        };
        ((my  $code) = $self->{('code')});
        if ((ref(($code ne '')))) {
            ((my  @args) = ());
            for (@{$self->{('arguments')}}) {
                push(@args, $_->emit_javascript() )
            };
            return ((Javascript::tab($level) . '(' . $self->{('code')}->emit_javascript() . ')(' . join(',', @args) . ')'))
        };
        if ((($code eq 'infix:<' . chr(61) . '>>'))) {
            return ((Javascript::tab($level) . join(', ', map($_->emit_javascript(), @{$self->{('arguments')}}))))
        };
        if ((exists($op_infix_js{$code}))) {
            return ((Javascript::tab($level) . '(' . join($op_infix_js{$code}, map($_->emit_javascript(), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'eval'))) {
            return (('eval(perl5_to_js(' . Javascript::to_str($self->{('arguments')}->[0]) . '))'))
        };
        if ((($code eq 'undef'))) {
            if ((($self->{('arguments')} && @{$self->{('arguments')}}))) {
                return (('(' . $self->{('arguments')}->[0]->emit_javascript() . ' ' . chr(61) . ' null)'))
            };
            return ('null')
        };
        if ((($code eq 'defined'))) {
            return ((Javascript::tab($level) . '(' . join(' ', map($_->emit_javascript(), @{$self->{('arguments')}})) . ' ' . chr(33) . chr(61) . ' null)'))
        };
        if ((($code eq 'shift'))) {
            if ((($self->{('arguments')} && @{$self->{('arguments')}}))) {
                return (('PKG.shift(' . join(', ', map($_->emit_javascript(), @{$self->{('arguments')}})) . ')'))
            };
            return ('PKG.shift(List__)')
        };
        if ((($code eq 'map'))) {
            ((my  $fun) = $self->{('arguments')}->[0]);
            ((my  $list) = $self->{('arguments')}->[1]);
            return (('(function (a_) ' . chr(123) . ' ' . 'var out ' . chr(61) . ' []' . chr(59) . ' ' . 'if ( a_ ' . chr(61) . chr(61) . ' null ) ' . chr(123) . ' return out' . chr(59) . ' ' . chr(125) . chr(59) . ' ' . 'for(var i ' . chr(61) . ' 0' . chr(59) . ' i < a_.length' . chr(59) . ' i++) ' . chr(123) . ' ' . 'var v__ ' . chr(61) . ' a_[i]' . chr(59) . ' ' . 'out.push(' . $fun->emit_javascript() . ')' . chr(125) . chr(59) . ' ' . 'return out' . chr(59) . ' ' . chr(125) . ')(' . $list->emit_javascript() . ')'))
        };
        if ((($code eq 'prefix:<' . chr(33) . '>'))) {
            return (('( ' . Javascript::to_bool($self->{('arguments')}->[0]) . ' ' . chr(63) . ' false : true)'))
        };
        if ((($code eq 'prefix:<' . chr(36) . '>'))) {
            ((my  $arg) = $self->{('arguments')}->[0]);
            return (('(' . $arg->emit_javascript() . ')._scalar_'))
        };
        if ((($code eq 'prefix:<' . chr(64) . '>'))) {
            ((my  $arg) = $self->{('arguments')}->[0]);
            return ((Javascript::tab($level) . '(' . $arg->emit_javascript() . ' ' . chr(63) . ' ' . $arg->emit_javascript() . ' : ' . $arg->emit_javascript() . ' ' . chr(61) . ' new ArrayRef([])' . ')._array_'))
        };
        if ((($code eq 'prefix:<' . chr(37) . '>'))) {
            ((my  $arg) = $self->{('arguments')}->[0]);
            return (('(' . $arg->emit_javascript() . ')._hash_'))
        };
        if ((($code eq 'circumfix:<[ ]>'))) {
            return (('(new ArrayRef(Array.prototype.slice.call(' . join(', ', map($_->emit_javascript(), @{$self->{('arguments')}})) . ')))'))
        };
        if ((($code eq 'prefix:<' . chr(92) . '>'))) {
            ((my  $arg) = $self->{('arguments')}->[0]);
            if (($arg->isa('Var'))) {
                if ((($arg->sigil() eq chr(64)))) {
                    return (('(new ArrayRef(' . $arg->emit_javascript() . '))'))
                };
                if ((($arg->sigil() eq chr(37)))) {
                    return (('(new HashRef(' . $arg->emit_javascript() . '))'))
                };
                if ((($arg->sigil() eq chr(38)))) {
                    if (($arg->{('namespace')})) {
                        return (('NAMESPACE[' . chr(34) . $arg->{('namespace')} . chr(34) . '].' . $arg->{('name')}))
                    }
                    else {
                        return (('PKG.' . $arg->{('name')}))
                    }
                }
            };
            return (('(new ScalarRef(' . $arg->emit_javascript() . '))'))
        };
        if ((($code eq 'postfix:<++>'))) {
            return (('(' . join(' ', map($_->emit_javascript(), @{$self->{('arguments')}})) . ')++'))
        };
        if ((($code eq 'postfix:<-->'))) {
            return (('(' . join(' ', map($_->emit_javascript(), @{$self->{('arguments')}})) . ')--'))
        };
        if ((($code eq 'prefix:<++>'))) {
            return (('++(' . join(' ', map($_->emit_javascript(), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'prefix:<-->'))) {
            return (('--(' . join(' ', map($_->emit_javascript(), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'infix:<x>'))) {
            return (('str_replicate(' . join(', ', map($_->emit_javascript(), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'list:<.>'))) {
            return (('(' . join(' + ', map(Javascript::to_str($_), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'infix:<+>'))) {
            return (('add' . '(' . join(', ', map($_->emit_javascript(), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'prefix:<+>'))) {
            return (('(' . $self->{('arguments')}->[0]->emit_javascript() . ')'))
        };
        if ((($code eq 'infix:<..>'))) {
            return (('(function (a) ' . chr(123) . ' ' . 'for (var i' . chr(61) . $self->{('arguments')}->[0]->emit_javascript() . ', l' . chr(61) . $self->{('arguments')}->[1]->emit_javascript() . chr(59) . ' ' . 'i<' . chr(61) . 'l' . chr(59) . ' ++i)' . chr(123) . ' ' . 'a.push(i) ' . chr(125) . chr(59) . ' ' . 'return a ' . chr(125) . ')([])'))
        };
        if ((($code eq 'infix:<' . chr(38) . chr(38) . '>') || ($code eq 'infix:<and>'))) {
            return (('and' . '(' . $self->{('arguments')}->[0]->emit_javascript() . ', ' . 'function () ' . chr(123) . ' return ' . $self->{('arguments')}->[1]->emit_javascript() . chr(59) . ' ' . chr(125) . ')'))
        };
        if ((($code eq 'infix:<' . chr(124) . chr(124) . '>') || ($code eq 'infix:<or>'))) {
            return (('or' . '(' . $self->{('arguments')}->[0]->emit_javascript() . ', ' . 'function () ' . chr(123) . ' return ' . $self->{('arguments')}->[1]->emit_javascript() . chr(59) . ' ' . chr(125) . ')'))
        };
        if ((($code eq 'infix:<' . chr(47) . chr(47) . '>'))) {
            return ((('defined_or') . '(' . $self->{('arguments')}->[0]->emit_javascript() . ', ' . 'function () ' . chr(123) . ' return ' . $self->{('arguments')}->[1]->emit_javascript() . chr(59) . ' ' . chr(125) . ')'))
        };
        if ((($code eq 'exists'))) {
            ((my  $arg) = $self->{('arguments')}->[0]);
            if (($arg->isa('Lookup'))) {
                ((my  $v) = $arg->obj());
                if ((($v->isa('Var') && ($v->sigil() eq chr(36))))) {
                    ($v = Var->new(('sigil' => chr(37)), ('namespace' => $v->namespace()), ('name' => $v->name())));
                    return (('(' . $v->emit_javascript() . ').hasOwnProperty(' . ($arg->index_exp())->emit_javascript() . ')'))
                };
                return (('(' . $v->emit_javascript() . ')._hash_.hasOwnProperty(' . ($arg->index_exp())->emit_javascript() . ')'))
            };
            if (($arg->isa('Call'))) {
                if ((($arg->method() eq 'postcircumfix:<' . chr(123) . ' ' . chr(125) . '>'))) {
                    return (('(' . $arg->invocant()->emit_javascript() . ')._hash_.hasOwnProperty(' . $arg->{('arguments')}->emit_javascript() . ')'))
                }
            }
        };
        if ((($code eq 'ternary:<' . chr(63) . chr(63) . ' ' . chr(33) . chr(33) . '>'))) {
            return ((Javascript::tab($level) . '( ' . Javascript::to_bool($self->{('arguments')}->[0]) . ' ' . chr(63) . ' ' . ($self->{('arguments')}->[1])->emit_javascript() . ' : ' . ($self->{('arguments')}->[2])->emit_javascript() . ')'))
        };
        if ((($code eq 'circumfix:<( )>'))) {
            return ((Javascript::tab($level) . '(' . join(', ', map($_->emit_javascript(), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'infix:<' . chr(61) . '>'))) {
            return (emit_javascript_bind($self->{('arguments')}->[0], $self->{('arguments')}->[1], $level))
        };
        if ((($code eq 'return'))) {
            return ((Javascript::tab($level) . 'throw(' . ((($self->{('arguments')} && @{$self->{('arguments')}}) ? $self->{('arguments')}->[0]->emit_javascript() : 'null')) . ')'))
        };
        if (($self->{('namespace')})) {
            if (((($self->{('namespace')} eq 'JS') && ($code eq 'inline')))) {
                if (($self->{('arguments')}->[0]->isa('Val::Buf'))) {
                    return ($self->{('arguments')}->[0]->{('buf')})
                }
                else {
                    die(('JS::inline needs a string constant'))
                }
            };
            ($code = ('NAMESPACE[' . chr(34) . $self->{('namespace')} . chr(34) . '].' . ($code)))
        }
        else {
            ($code = ('PKG.' . $code))
        };
        ((my  @args) = ());
        for (@{$self->{('arguments')}}) {
            push(@args, $_->emit_javascript() )
        };
        (Javascript::tab($level) . $code . '(' . join(', ', @args) . ')')
    };
    sub emit_javascript_bind {
        ((my  $parameters) = shift());
        ((my  $arguments) = shift());
        ((my  $level) = shift());
        if ((($parameters->isa('Var') && ($parameters->sigil() eq chr(64))) || ($parameters->isa('Decl') && ($parameters->var()->sigil() eq chr(64))))) {
            ((my  $items) = Javascript::preprocess_array_interpolation([    $arguments]));
            return ((Javascript::tab($level) . '(' . $parameters->emit_javascript() . ' ' . chr(61) . ' interpolate_array(' . join(', ', map($_->emit_javascript(), @{$items})) . '))'))
        }
        else {
            if ((($parameters->isa('Var') && ($parameters->sigil() eq chr(37))) || ($parameters->isa('Decl') && ($parameters->var()->sigil() eq chr(37))))) {
                ((my  $items) = Javascript::preprocess_array_interpolation([    $arguments]));
                return ((Javascript::tab($level) . '(' . $parameters->emit_javascript() . ' ' . chr(61) . ' array_to_hash(interpolate_array(' . join(', ', map($_->emit_javascript(), @{$items})) . ')))'))
            }
        };
        (Javascript::tab($level) . '(' . $parameters->emit_javascript() . ' ' . chr(61) . ' ' . $arguments->emit_javascript() . ')')
    }
});
package If;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $cond) = $self->{('cond')});
        if ((($cond->isa('Var') && ($cond->sigil() eq chr(64))))) {
            ($cond = Apply->new(('code' => 'prefix:<' . chr(64) . '>'), ('arguments' => [    $cond])))
        };
        ((my  $body) = Perlito5::Javascript::LexicalBlock->new(('block' => $self->{('body')}->stmts()), ('needs_return' => 0)));
        ((my  $s) = (Javascript::tab($level) . 'if ( ' . Javascript::to_bool($cond) . ' ) ' . chr(123) . ' ' . '(function () ' . chr(123) . (chr(10)) . $body->emit_javascript_indented(($level + 1)) . (chr(10)) . Javascript::tab($level) . chr(125) . ')()' . chr(59) . ' ' . chr(125)));
        if ((@{$self->{('otherwise')}->stmts()})) {
            ((my  $otherwise) = Perlito5::Javascript::LexicalBlock->new(('block' => $self->{('otherwise')}->stmts()), ('needs_return' => 0)));
            ($s = ($s . (chr(10)) . Javascript::tab($level) . 'else ' . chr(123) . ' ' . '(function () ' . chr(123) . (chr(10)) . $otherwise->emit_javascript_indented(($level + 1)) . (chr(10)) . Javascript::tab($level) . chr(125) . ')()' . chr(59) . ' ' . chr(125)))
        };
        return ($s)
    }
});
package While;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $body) = Perlito5::Javascript::LexicalBlock->new(('block' => $self->{('body')}->stmts()), ('needs_return' => 0)));
        return ((Javascript::tab($level) . 'for ( ' . (($self->{('init')} ? ($self->{('init')}->emit_javascript() . chr(59) . ' ') : chr(59) . ' ')) . (($self->{('cond')} ? (Javascript::to_bool($self->{('cond')}) . chr(59) . ' ') : chr(59) . ' ')) . (($self->{('continue')} ? ($self->{('continue')}->emit_javascript() . ' ') : ' ')) . ') ' . chr(123) . ' ' . '(function () ' . chr(123) . (chr(10)) . $body->emit_javascript_indented(($level + 1)) . ' ' . chr(125) . ')()' . ' ' . chr(125)))
    }
});
package For;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $cond) = $self->{('cond')});
        if ((!((($cond->isa('Var') && ($cond->sigil() eq chr(64))))))) {
            ($cond = Apply->new(('code' => 'prefix:<' . chr(64) . '>'), ('arguments' => [    Lit::Array->new(('array1' => [    $cond]))])))
        };
        ((my  $body) = Perlito5::Javascript::LexicalBlock->new(('block' => $self->{('body')}->stmts()), ('needs_return' => 0)));
        ((my  $sig) = 'v__');
        if (($self->{('body')}->sig())) {
            ($sig = $self->{('body')}->sig()->emit_javascript_indented(($level + 1)))
        };
        (Javascript::tab($level) . '(function (a_) ' . chr(123) . ' for (var i_ ' . chr(61) . ' 0' . chr(59) . ' i_ < a_.length ' . chr(59) . ' i_++) ' . chr(123) . ' ' . ('(function (' . $sig . ') ' . chr(123) . chr(10)) . $body->emit_javascript_indented(($level + 1)) . ' ' . chr(125) . ')(a_[i_]) ' . chr(125) . ' ' . chr(125) . ')' . '(' . $cond->emit_javascript() . ')')
    }
});
package Decl;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        (Javascript::tab($level) . $self->{('var')}->emit_javascript())
    };
    sub emit_javascript_init {
        ((my  $self) = shift());
        if ((($self->{('decl')} eq 'my'))) {
            ((my  $str) = '');
            ($str = ($str . 'var ' . ($self->{('var')})->emit_javascript() . ' ' . chr(61) . ' '));
            if ((($self->{('var')})->sigil() eq chr(37))) {
                ($str = ($str . chr(123) . chr(125) . chr(59) . (chr(10))))
            }
            else {
                if ((($self->{('var')})->sigil() eq chr(64))) {
                    ($str = ($str . '[]' . chr(59) . (chr(10))))
                }
                else {
                    ($str = ($str . 'null' . chr(59) . (chr(10))))
                }
            };
            return ($str)
        }
        else {
            die(('not implemented: Decl ' . chr(39) . $self->{('decl')} . (chr(39))))
        }
    }
});
package Sub;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $s) = ('function () ' . chr(123) . (chr(10)) . Javascript::tab(($level + 1)) . 'var List__ ' . chr(61) . ' Array.prototype.slice.call(arguments)' . chr(59) . (chr(10)) . (Perlito5::Javascript::LexicalBlock->new(('block' => $self->{('block')}), ('needs_return' => 1), ('top_level' => 1)))->emit_javascript_indented(($level + 1)) . (chr(10)) . Javascript::tab($level) . chr(125)));
        (($self->{('name')} ? ('make_sub(__PACKAGE__, ' . chr(34) . $self->{('name')} . chr(34) . ', ' . $s . ')') : $s))
    }
});
package Do;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $block) = $self->simplify()->block());
        return ((Javascript::tab($level) . '(function () ' . chr(123) . (chr(10)) . (Perlito5::Javascript::LexicalBlock->new(('block' => $block), ('needs_return' => 1)))->emit_javascript_indented(($level + 1)) . (chr(10)) . Javascript::tab($level) . chr(125) . ')()'))
    }
});
package Use;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        (Javascript::tab($level) . chr(47) . chr(47) . ' use ' . $self->{('mod')} . (chr(10)))
    }
});

1;
