# Chapter3.Data Simulation

<hr>
<b>Fundamental concepts</b>: Design and build logical components that plug into your IoT applications and can interact with the emulated sensors and actuators.
<hr>

Processing data from sensors and sending commands to actuators are important capabilities of an end-to-end IoT system. Sensors and actuators, as you’ll soon see, are truly the “edge of the edge,” serving as the final interface between the physical and logical worlds.

然而，传感和驱动能力带来了一个难题：有无数类型的硬件支持这种类型的功能，每一种都有自己的一组接口要求。 为了缓解这种情况，并保持在编程领域以支持我们的初始用例，本章将重点介绍使用数据模拟和硬件仿真来提供对物联网进行编程所需的“物理世界”接口。

## Simulating Sensors and Actuators

To simulate a sensor, there are a few things you'll need to know, including:
- the data type representing the value it will generate
- the type of sensor and its purpose(which can be represented via a name and an ID value)
- the range of data the sensor can support
  
Finally, you’ll need access to a data source that your simulated sensor logic can use. There are many ways to integrate a data source within the CDA, so I’ll posit the data itself must be local to the CDA. This means that you’ll essentially have two options: use a fixed data set for each sensor (which can simply be stored in the filesystem), or generate a dynamic data set relative to each sensor. 

上课的时候用的后者：dynamic data set relative to each sensor

``SensorDataGenerator`` 是一个相对简单的类，可用于生成表示 CDA 将收集的传感器测量值的数据集，例如温度、压力和湿度。 它依赖 ``NumPy`` 包在一段时间内在给定范围内生成一系列浮点值。 它还允许您引入不同程度的噪声或波动，并将它们应用于每个数据值。

虽然这是一种生成模拟数据的非常基本的方法，专为测试和原型设计目的而设计，但它将根据在 ``PiotConfig.props`` 中为 CDA 和 GDA 设置的配置属性，在每个传感器的数据中提供足够的多样性来触发驱动事件。 将此类与配置边界值结合起来提供了一个初始模型功能，它封装了我们将在本章中使用的数据的限制、范围和时间条目。


