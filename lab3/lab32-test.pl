#! /usr/bin/perl
while (true)
{
	print "Меню:\n";
	print "1. Добавление\n";
	print "2. Удаление\n";
	print "3. Вывод дерева\n";
	print "4. Генерация\n";
	print "5. Выход\n";
	print "Введите номер команды: "; 
	 $menu = <>;
	 if ($menu == 4)
	 {
		 print "Введите количество элементов: ";
		 $count = <>;
		 chomp($count); 
		 for (my $i = 0; $i <$count; $i++)
		 {
			 $value = int(rand(128));
			 chomp($value);
			 add($head, $value);
		 }
	 }
	 elsif ($menu == 1)
	 {
		 print "Введите элемент: ";
		 $value = <>;
		 chomp($value);
		 add($head, $value);
	 }
	 elsif($menu == 2) 
	 {
		 print "Введите элемент, который нужно удалить: ";
		 $value = <>;
		 chomp($value);
		 del($head, $value); 
	 }
	 elsif($menu == 3) 
	 {
		 print "Структура дерева:\n";
		 show($head, 0);
	 }
	 elsif ($menu == 5) 
	 {
		exit;
	 } 
	 else
	 {
		 print "Нет такой команды\n";
		 next;
	 }
}

sub add() #добавление элмента в дерево
{
 my($item, $value) = @_;
 
 unless ($item) 
 {
	 $item = {};
	 $item ->{value} = $value;
	 $item ->{Left} = undef;
	 $item ->{Right} = undef;
	 $_[0] = $item;
	 return;
 } 
 
 if ($item -> {value} == $value) #проверка на наличие в дереве
 {
	 print "Элемент уже в дереве\n";
	 return;
 } 
 elsif ($item -> {value} < $value) #если элемент меньше
 { 
	 add($item -> {Right}, $value); #добавляем вправо
 }
 else 
 { 
	 add($item->{Left}, $value); #если больше, добавляем влево
 }
 
}

sub show {
    my($item, $i) = @_;
    my $j;
    unless($item) {
        return;
    } else {
        show($item->{Right}, ($i+4)); #меняем порядок вывода левого и правого поддеревьев
        $j = 0;
        while($j < $i) {
            print " ";
            $j++;
        }
        print "$item->{value}\n ";
        show($item->{Left}, ($i+4));
    }
    return;
}

sub del() #удаление
{
 my($item, $value) = @_;
 
 return unless ($item);
 
 if ($item->{value} == $value) #нашли узел в дереве
 {
 	my($buf1) = $_[0]; #присваиваем значение корня
 	my($buf2)=$buf1; 
 
 	if ($buf1->{Left}) 
 	{ 
 		$buf1 = $buf1->{Left}; #переходим на левую ветку (меньших значений)
 
 		unless($buf1->{Right})  #пока мы можем идти правее
 		{ 
 			$_[0] = $buf1;  
 			$buf1->{Right} = $item->{Right}; #делаем корень большим значением
 		}
 		else 
		{ 
 			while($buf1->{Right})  
 			{
 				$buf2 = $buf1;  #в buf2 заносим значение нового корня
 				$buf1 = $buf1->{Right}  #buf1 такое же значение, но как потомок правый
 			}
 
 			if ($buf1->{Left}) 
 			{
 				$buf2->{Right} = $buf1->{Left} 
 			}
 
 			$item->{value} = $buf1->{value}; #переприсваиваем значение корня, т.е. наиболее близкого к нему потомка по значению с левой стороны
 			undef %$buf1; #удаляем потомка
 		}
 	} 
 
 	elsif ($buf1->{Right}) #удаление, если у узласразу есть правый потомок без собственных потомков
 	{
 		$buf1 = $buf1->{Right}; #переходим на правую ветку (больших значений)
 		unless($buf1->{Left})
 		{ 
 			$_[0] = $buf1; 
 			$buf1->{Left}=$item->{Left}; #делаем корень меньшим значением
 		}
 		else
 		{
 			while($buf1->{Left})
 			{
 				$buf2 = $buf1; #в buf2 заносим значение нового корня
 				$buf1 = $buf1->{Left} #buf1 такое же значение, но как потомок левый
 			}
 
 			if ($buf1 -> {Right}) 
 			{
 				$buf2->{Left} = $buf1->{Right}
 			}
 
 			$item->{value} = $buf1->{value}; #переприсваиваем значение корня
 			undef %$buf1; #удаляем потомка
 		}
 	} 

 	else 
 	{
 		$_[0] = undef; #если у узла нет дочерних узлов, просто удаляем узел
 	}
 	}

 	elsif ($item->{value} < $value) 
 	{
 		del($item->{Right}, $value); #у узла есть правый дочерний узел, заменяем удаляемый узел на его потомка
 	}
 	else 
 	{ 
 		del($item->{Left}, $value); #у узла есть левый дочерний узел, заменяем удаляемый узел на его потомка
 	}
}

