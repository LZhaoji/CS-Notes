# Bean的自动装配
- 自动装配是Spring满足bean依赖的一种方式
- Spring会在上下文中自动寻找，并自动给bean装配属性

在Spring中有三种装配的方式：
1. 在xml中显式的配置；
2. 在java中显式配置；
3. 隐式的自动装配bean【重要】

## 测试
环境搭建：创建项目，一个人有两个宠物！
```xml
    <bean id="cat" class="com.kuang.pojo.Cat"/>
    <bean id="dog" class="com.kuang.pojo.Dog"/>

    <bean id="people" class="com.kuang.pojo.People">
        <property name="name" value="你好棒呀！！！"/>
        <property name="cat" ref="cat"/>
        <property name="dog" ref="dog"/>
    </bean>

```
## ByName自动装配
```xml
<bean id="cat" class="com.kuang.pojo.Cat"/>
<bean id="dog" class="com.kuang.pojo.Dog"/>    
<!--
    byName：会自动在容器上下文中查找，和自己对象set方法后面的值对应的bean id！
 -->
<bean id="people" class="com.kuang.pojo.People" autowire="byName">
    <property name="name" value="你好棒呀！！！"/>
</bean>

```
## ByType自动装配
```xml
<!-- 因为是自动对Type进行装配，所以可以不对Cat和Dog赋id值 -->
<bean  class="com.kuang.pojo.Cat"/>
<bean  class="com.kuang.pojo.Dog"/>
<!--
    byType：会自动在容器上下文中查找，和自己对象属性类型相同的bean！
-->
<bean id="people" class="com.kuang.pojo.People" autowire="byType">
    <property name="name" value="你好棒呀！！！"/>
</bean>


```
小结：
- ByName的时候，需要保证所有bean的id唯一，并且这个bean需要和自动注入的属性的set方法的值一致！
- ByType的时候，需要保证所有bean的class唯一，并且这个bean需要和自动注入的属性的类型一致！

## 使用注解实现自动装配
jdk1.5支持的注解，Spring2.5就支持注解了！

要使用注解须知：
1. 导入约束
2. 配置注解的支持：context:annotation-config
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
	        https://www.springframework.org/schema/beans/spring-beans.xsd
	        http://www.springframework.org/schema/context
	        https://www.springframework.org/schema/context/spring-context.xsd">
		
		<!--开启注解的支持    -->
        <context:annotation-config/>
</beans>
```
<strong>@Autowired 自动配置</strong>
直接在属性上使用即可！也可以在set方法上使用！

使用Autowried我们就可以不用编写set方法了，前提是你这个自动配置的属性在IOC(Spring)容器中存在，且符合名字ByName！

#### Spring注解@Resource和@Autowired区别对比
@Resource和@Autowired都是做bean的注入时使用，其实@Resource并不是Spring的注解，它的包是javax.annotation.Resource，需要导入，但是Spring支持该注解的注入。

1、共同点

两者都可以写在字段和setter方法上。两者如果都写在字段上，那么就不需要再写setter方法。

2、不同点

（1）@Autowired

@Autowired为Spring提供的注解，需要导入包org.springframework.beans.factory.annotation.Autowired;只按照byType注入。
```java
public class TestServiceImpl {
    // 下面两种@Autowired只要使用一种即可
    @Autowired
    private UserDao userDao; // 用于字段上
    
    @Autowired
    public void setUserDao(UserDao userDao) { // 用于属性的方法上
        this.userDao = userDao;
    }
}
```

@Autowired注解是按照类型（byType）装配依赖对象，默认情况下它要求依赖对象必须存在，如果允许null值，可以设置它的required属性为false。如果我们想使用按照名称（byName）来装配，可以结合@Qualifier注解一起使用。(通过类型匹配找到多个candidate,在没有@Qualifier、@Primary注解的情况下，会使用对象名作为最后的fallback匹配)如下:
```java
public class TestServiceImpl {
    @Autowired
    @Qualifier("userDao")
    private UserDao userDao; 
}
```
（2）@Resource

@Resource默认按照ByName自动注入，由J2EE提供，需要导入包javax.annotation.Resource。@Resource有两个重要的属性：name和type，而Spring将@Resource注解的name属性解析为bean的名字，而type属性则解析为bean的类型。所以，如果使用name属性，则使用byName的自动注入策略，而使用type属性时则使用byType自动注入策略。如果既不制定name也不制定type属性，这时将通过反射机制使用byName自动注入策略。
```java
public class TestServiceImpl {
    // 下面两种@Resource只要使用一种即可
    @Resource(name="userDao")
    private UserDao userDao; // 用于字段上
    
    @Resource(name="userDao")
    public void setUserDao(UserDao userDao) { // 用于属性的setter方法上
        this.userDao = userDao;
    }
}
```
注：最好是将@Resource放在setter方法上，因为这样更符合面向对象的思想，通过set、get去操作属性，而不是直接去操作属性。

@Resource装配顺序：

①如果同时指定了name和type，则从Spring上下文中找到唯一匹配的bean进行装配，找不到则抛出异常。

②如果指定了name，则从上下文中查找名称（id）匹配的bean进行装配，找不到则抛出异常。

③如果指定了type，则从上下文中找到类似匹配的唯一bean进行装配，找不到或是找到多个，都会抛出异常。

④如果既没有指定name，又没有指定type，则自动按照byName方式进行装配；如果没有匹配，则回退为一个原始类型进行匹配，如果匹配则自动装配。

@Resource的作用相当于@Autowired，只不过@Autowired按照byType自动注入。