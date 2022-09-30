# 1、IoT的简单介绍

why CDA called constrained?
limited CPU, memory, and power resources.

一般情况下，IoT整个步骤为：
Desired Outcomes -> Stuff you need 
-> How to get the stuff you need 
-> what to do with the stuff you get

telemetry 遥测是指传感器在测量现场收集测量对象的数据后，
数据通过无线传输、电话或计算机网络、简讯和GSM等各种方式
传送至远距离的接收设备以供监测人员监测。

什么是Measure\Model\Manage stuff?  M3 concept
- Measure Everything(mostly)测量所有想要的数据
  - Generate telemetry建立遥测
    - Collect data收集数据
        - Basic validation基本有效
    - Encode and connect编码并连接
        - Generate a usable dataset and send it on its way
            生成一个有用的数据集并把它发送出去

- Create a Model建立模型
  - Define a template定义一个模版
    - Represents a baseline of 'nominal'定义一个正常范围
        - Calibration and collection ranges校准和收集范围
        - Provenance rules出处规则
    - Can be driven by either(or both) of:可以由以下任一（或两者）驱动：
        - Existing patterns(based on historical analysis)现有模式（基于历史分析）
        - Desired patterns(based on preferences)所需的模式（基于偏好）
- Manage from the Model管理模型
  - Decide决策
    - Determine if an action is required确定是否需要执行操作
        - Trigger an adjustment if/as needed根据需要触发调整
    - Determine what(else)should be measured确定应该测量什么（其他）
        - Quantify via outcome-oriented KPI's* and their respective metrics通过以结果为导向的 KPI* 及其各自的指标进行量化


What is IOT? IoT is the network of physical objects that contain embedded technology to communicate and sense or interact with their internal states or the external environment.

IoT devices are/can...
- Embedded
- Collect Context
- Generate Telemetry
- Connected

IoT services can/are...
- Precess and Store Telemetry
- 'Cloud Ready'
- Act and Deliver Value

# 2、Architecture Tiers架构层

M3：A look at basic IoT data/decision flow
* Measure:Collect the data(physical word->computing device)
* Model:Establish baselines,validate and store the data
* Manage:Analyze the data(what happened and why)and take action
![Data Flows](IoT%20Architecture%20Tiers.png)

Tiers:
Components align to one of two tiers,or logical locations
* Edge Tier:Collection source/action target and some analytics
* Cloud Tier:Historical(& Real-time)time-series data/analysis results storage;advanced analytics and reporting;scalability
![Tiered View of Data Flows](Tiered%20View%20of%20Data%20Flows.png)

* The cloud tier will host a bunch of services and other infrasturcture
* The edge tier will be split into a gateway device and constrained device

* CDA:interact with actuators/sensors
* GDA:interact with CDA and cloud/internet


Why need architecture?
Architecture gives a system design guideline.
Need to consider: Deployment,Connectivity,Security,System Management,Data Management,Ontologies & Semantics,Computing


现在流行的物联网架构已经从两层结构Edge Tier and Cloud Tier转变为：
Edge Tier,(Platform and Enterprise) Tier

Why?
In an Industial IoT Context,it may make sense-and even be necessary

* The Plateform Tier Provides the interace between edge and enterprise
* Allows separation of orchestration and management processing functionality from business users in Enterprise Tier

Identify tiers and key components --- create an RA

why should you do this? Because a Reference Atchitecture... : 
- Serves as a template : 
  * Provides a common framework to help guide system development.Guideline inform what we must/must not do.

Functional Domain Components:
- purpose: 
  * Define building blocks for establishing a concrete architecture
- Components:
  * Control Domain
  * Operation Domain
  * Information Domain
  * Application Domain
  * Business Domain
- Mappings
  * Info flow:Increased impact as exchanges move up the stack
    * Data becomes richer
    * Interactions likely broader/longer
    * Potential impact likely greater

Mapping into a three-tier architecture:
- Purpose
  * Technical representation of IIoT system,including required technologies and components
- Components
  * Three architectural patterns
    * Three-tier pattern 
    * Gateway-mediated Edge Connectivity and Management pattern
    * Layered Databus pattern
- Mappings
  * Baseline for all three is the three-tier architecture pattern
  * Three-tier pattern shown

Gateway-mediated edge connectivity and management pattern
- Purpose 
  * Represents a local edge tier connectivity solution
- Benefits
  * Functional localization
  * Segments components via gateway to allow scalability
- Challenges
  * Effectivity for dynamic systems not fixed to a gateway
- Topologies
  * Hub and Spoke
    * Edge devices connnect into the same gateway, with routing via the gateway
  * Mesh(P2P/peer-to-peer)
    * Edge devices may connect to each other, with some providing routing
- Capabilities
  * Local connectivity
  * Local data processing
  * Network and protocol bridging
  * Agent for device management

Layered Databus pattern
- Purpose
  * Separation of concerns, isolation of functionality, security, reliability
- Components
  * Four databus constructs
    * Machine Databus:Local ontrol
    * Unit Databus:Edge device system management
    * Site Databus:Supervisory control and monitoring
    * Inter-Site Databus:Federaion for complex interactions and analytics
- Mappings
- Benefits
  * High performance device to device integration
  * Automatic data discovery
  * Scalable integration
  * Natural redundancy
  * Hierarchical isolation
- Chanllenges
  * Complexity and Cost
- Where might we see this?
  * Industries:Automotive,e-bike shifters

