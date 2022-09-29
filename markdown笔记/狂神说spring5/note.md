## 注解说明
- @Autowired：自动装配通过类型
  如果Autowired不能唯一自动配置上属性，需要通过@Qualifier(value="xxx")
- @Nullable：字段标记了这个注解，说明这个字段可以为null
- @Resource：自动装配通过名字。
- @Component：组建，放在类上，说明这个类被Spring管理了，就是bean！