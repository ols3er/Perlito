package Iterator::Of::String {
    import => "java.util.Iterator",
    java_type => "Iterator<String>",
};
package ArrayList::Of::String {
   import => "java.util.ArrayList",
   java_type => "ArrayList<String>",
}

sub foo {

    my $x;

    my ArrayList::Of::String $listA = ArrayList::Of::String->new();
    $listA->add("element 1");
    $listA->add("element 2");
    $listA->add("element 3");

    $x = $listA;
    return $x;
}


my $bar = foo();

my ArrayList::Of::String $arr = $bar->to_ArrayListOfString();
my Iterator::Of::String $iterator = $arr->iterator();

while($iterator->hasNext()) {
  my $element = $iterator->next();
  say $element;
}

