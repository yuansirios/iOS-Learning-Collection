
数组（字典）中添加弱引用；NSValue、NSPointerArray、NSHashTable、NSMapTable、WeakMutableArray

>也许你对NSArray使用了如指掌,每个加入到NSArry的对象都会被NSArray强持有。有时候,这种特性不是我们想要的结果。
有时候,我们想将对象存储起来,但是不想让数组增加了这个对象的引用计数,这个时候,WeakMutableArray才是你想要的。

![580c4b9c3c3168b778d5ed38ea2bf404](img/示例_1.png)


#### 方法一：NSValue
iOS6.0之前，可以用[NSValue valueWithNonretainedObject:person]获取到对象的value，将这个value添加到数组中。效果如下：

![7d6f822fb33896a299494041b5647dd7](img/NSValue.png)

#### 方法二：NSPointerArray
在iOS6.0之后出现了NSPointerArray。 
他的初始化方法，可以创建强引用，弱引用对象的数组

```
+ (NSPointerArray *)strongObjectsPointerArray NS_AVAILABLE(10_8, 6_0);
+ (NSPointerArray *)weakObjectsPointerArray NS_AVAILABLE(10_8, 6_0);
```

![4128be9a041cf47c9c34855964fd0f10](img/NSPointerArray.png)

>同样，在iOS6.0之后 
有NSHashTable类似于NSSet 
有NSMapTable为NSDictionary 
具体使用方法可以参考API

#### 方法三：NSHashTable

![f6e644272a24f9e79ffa3716efd32a85](img/NSHashTable.png)

#### 方法四：NSMapTable
![61e91aa711a09a29247dc2192f9fdac6](img/NSMapTable.png)

#### 方法五：WeakMutableArray

![c14cc868a33e5a2a30e658a493e44f25](img/WeakMutableArray.png)

