within doe_small_demo.Substations;
model HeatingIndirect_2
   "Indirect heating energy transfer station for district energy systems"
  extends Buildings.Fluid.Interfaces.PartialFourPortInterface(
    redeclare final package Medium1=Medium,
    redeclare final package Medium2=Medium,
    final m1_flow_nominal=mDis_flow_nominal,
    final m2_flow_nominal=mBui_flow_nominal,
    show_T=false);
  replaceable package Medium=Modelica.Media.Interfaces.PartialMedium
    "Medium in the component";
  // mass flow rates
  parameter Modelica.Units.SI.MassFlowRate mDis_flow_nominal(
    final min=0,
    start=6.113)
     "Nominal mass flow rate of primary (district) heating side";
  parameter Modelica.Units.SI.MassFlowRate mBui_flow_nominal(
    final min=0,
    start=1.692)
     "Nominal mass flow rate of secondary (building) heating side";
  // Primary supply control valve
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal(
    final min=0,
    final displayUnit="Pa")=6000
     "Nominal pressure drop of fully open control valve";
  // Heat exchanger
  parameter Modelica.Units.SI.PressureDifference dp1_nominal(
    final min=0,
    start=500,
    final displayUnit="Pa")
    "Nominal pressure difference on primary side"
    annotation (Dialog(group="Heat exchanger"));
  parameter Modelica.Units.SI.PressureDifference dp2_nominal(
    final min=0,
    start=500,
    final displayUnit="Pa")
    "Nominal pressure difference on secondary side"
    annotation (Dialog(group="Heat exchanger"));
  parameter Boolean use_Q_flow_nominal=true
    "Set to true to specify Q_flow_nominal and temperatures, or to false to specify effectiveness"
    annotation (Dialog(group="Heat exchanger"));
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal(
    final min=0,
    start=8000)
     "Nominal heat transfer"
    annotation (Dialog(group="Heat exchanger"));
  parameter Modelica.Units.SI.Temperature T_a1_nominal(
    min=0+273,
    max=100+273.15,
    start=54+273.15,
    final displayUnit="K")
    "Nominal temperature at port a1"
    annotation (Dialog(group="Heat exchanger"));
  parameter Modelica.Units.SI.Temperature T_a2_nominal(
    min=0+273,
    max=100+273.15,
    start=50+273.15,
    final displayUnit="K")
    "Nominal temperature at port a2"
    annotation (Dialog(group="Heat exchanger"));
  parameter Modelica.Units.SI.Efficiency eta(
    final min=0,
    final max=0.8)=0.8
     "Constant effectiveness"
    annotation (Dialog(group="Heat exchanger"));
  // Controller parameters
  parameter Modelica.Blocks.Types.SimpleController controllerType=Modelica.Blocks.Types.SimpleController.PI
    "Type of controller"
    annotation (Dialog(tab="Controller"));
  parameter Real k(
    final min=0,
    final unit="1")=1
    "Gain of controller"
    annotation (Dialog(tab="Controller"));
  parameter Modelica.Units.SI.Time Ti(
    min=Modelica.Constants.small)=120
    "Time constant of integrator block"
    annotation (Dialog(tab="Controller",enable=controllerType == Modelica.Blocks.Types.SimpleController.PI or controllerType == Modelica.Blocks.Types.SimpleController.PID));
  parameter Modelica.Units.SI.Time Td(
    final min=0)=0.1
    "Time constant of derivative block"
    annotation (Dialog(tab="Controller",enable=controllerType == Modelica.Blocks.Types.SimpleController.PD or controllerType == Modelica.Blocks.Types.SimpleController.PID));
  parameter Real yMax(
    start=1)=1
     "Upper limit of output"
    annotation (Dialog(tab="Controller"));
  parameter Real yMin=0
     "Lower limit of output"
    annotation (Dialog(tab="Controller"));
  parameter Real wp(
    final min=0)=1
    "Set-point weight for Proportional block (0..1)"
    annotation (Dialog(tab="Controller"));
  parameter Real wd(
    final min=0)=0
    "Set-point weight for Derivative block (0..1)"
    annotation (Dialog(tab="Controller",enable=controllerType == Modelica.Blocks.Types.SimpleController.PD or controllerType == Modelica.Blocks.Types.SimpleController.PID));
  parameter Real Ni(
    min=100*Modelica.Constants.eps)=0.9
    "Ni*Ti is time constant of anti-windup compensation"
    annotation (Dialog(tab="Controller",enable=controllerType == Modelica.Blocks.Types.SimpleController.PI or controllerType == Modelica.Blocks.Types.SimpleController.PID));
  parameter Real Nd(
    min=100*Modelica.Constants.eps)=10
    "The higher Nd, the more ideal the derivative block"
    annotation (Dialog(tab="Controller",enable=controllerType == Modelica.Blocks.Types.SimpleController.PD or controllerType == Modelica.Blocks.Types.SimpleController.PID));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialOutput
    "Type of initialization (1: NoInit, 2: SteadyState, 3: InitialState, 4: InitialOutput)"
    annotation (Evaluate=true,Dialog(group="Initialization",tab="Controller"));
  parameter Real xi_start=0
    "Initial or guess value value for integrator output (= integrator state)"
    annotation (Dialog(group="Initialization",tab="Controller",enable=controllerType == Modelica.Blocks.Types.SimpleController.PI or controllerType == Modelica.Blocks.Types.SimpleController.PID));
  parameter Real xd_start=0
    "Initial or guess value for state of derivative block"
    annotation (Dialog(group="Initialization",tab="Controller",enable=controllerType == Modelica.Blocks.Types.SimpleController.PD or controllerType == Modelica.Blocks.Types.SimpleController.PID));
  parameter Real yCon_start=0
    "Initial value of output from the controller"
    annotation (Dialog(group="Initialization",tab="Controller",enable=initType == Modelica.Blocks.Types.Init.InitialOutput));
  parameter Boolean reverseActing=true
    annotation (Dialog(tab="Controller"));
  Modelica.Blocks.Interfaces.RealInput TSetBuiSup(
    final quantity="ThermodynamicTemperature",
    final unit="K")
    "Setpoint temperature for building supply"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow(
    final quantity="Power",
    final unit="W",
    final displayUnit="kW")
    "Measured power demand at the ETS"
    annotation (Placement(transformation(extent={{100,140},{120,160}})));
  Modelica.Blocks.Interfaces.RealOutput Q(
    final quantity="Energy",
    final unit="J",
    final displayUnit="kWh")
    "Measured energy consumption at the ETS"
    annotation (Placement(transformation(extent={{100,100},{120,120}})));
  Buildings.Fluid.HeatExchangers.PlateHeatExchangerEffectivenessNTU hex(
    redeclare final package Medium1=Medium,
    redeclare final package Medium2=Medium,
    final m1_flow_nominal=mDis_flow_nominal,
    final m2_flow_nominal=mBui_flow_nominal,
    final dp1_nominal=dp1_nominal,
    final dp2_nominal=dp2_nominal,
    final configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
    final use_Q_flow_nominal=true,
    final Q_flow_nominal=Q_flow_nominal,
    final T_a1_nominal=T_a1_nominal,
    final T_a2_nominal=T_a2_nominal)
    "Indirect heating heat exchanger"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Buildings.Controls.Continuous.LimPID con(
    final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final k=k,
    final Td=Td,
    final yMax=yMax,
    final yMin=yMin,
    final Ti=Ti,
    final wp=wp,
    final wd=wd,
    final Ni=Ni,
    final Nd=Nd,
    final initType=Modelica.Blocks.Types.Init.InitialOutput,
    final xi_start=xi_start,
    final xd_start=xd_start,
    final y_start=yCon_start,
    final reverseActing=reverseActing,
    reset=Buildings.Types.Reset.Disabled,
    y_reset=0)
    "Controller"
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTDisSup(
    redeclare final package Medium=Medium,
    final m_flow_nominal=mDis_flow_nominal)
    "District-side (primary) supply temperature sensor"
    annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTDisRet(
    redeclare final package Medium=Medium,
    final m_flow_nominal=mDis_flow_nominal)
    "District-side (primary) return temperature sensor"
    annotation (Placement(transformation(extent={{70,50},{90,70}})));
  Modelica.Blocks.Continuous.Integrator int(
    k=1)
    "Integration"
    annotation (Placement(transformation(extent={{60,120},{80,100}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(
    redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTBuiSup(
    redeclare final package Medium=Medium,
    final m_flow_nominal=mBui_flow_nominal)
    "Building-side (secondary) supply temperature"
    annotation (Placement(transformation(extent={{-70,-70},{-90,-50}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare final package Medium=Medium,
    final m_flow_nominal=mDis_flow_nominal,
    final dpValve_nominal=dpValve_nominal,
    riseTime(
      displayUnit="s")=60,
    y_start=0)
    "District-side (primary) control valve"
    annotation (Placement(transformation(extent={{-30,70},{-10,50}})));
  Modelica.Blocks.Math.Gain cp(
    final k=cp_default)
    "Specifc heat multiplier to calculate heat flow rate"
    annotation (Placement(transformation(extent={{20,100},{40,120}})));
  Modelica.Blocks.Math.Product pro
    "Product"
    annotation (Placement(transformation(extent={{-20,100},{0,120}})));
  Modelica.Blocks.Math.Add dTDis(
    k1=-1,
    k2=+1)
    "Temperatur difference on the district side"
    annotation (Placement(transformation(extent={{-60,106},{-40,126}})));
protected
  final parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
    T=Medium.T_default,
    p=Medium.p_default,
    X=Medium.X_default)
    "Medium state at default properties";
  final parameter Modelica.Units.SI.SpecificHeatCapacity cp_default=Medium.specificHeatCapacityCp(
    sta_default)
    "Specific heat capacity of the fluid";
equation
   connect(hex.port_a2,port_a2)
    annotation (Line(points={{40,-6},{60,-6},{60,-60},{100,-60}},color={0,127,255}));
  connect(hex.port_b1,senTDisRet.port_a)
    annotation (Line(points={{40,6},{60,6},{60,60},{70,60}},color={0,127,255}));
  connect(val.port_b,hex.port_a1)
    annotation (Line(points={{-10,60},{0,60},{0,6},{20,6}},color={0,127,255}));
  connect(senMasFlo.port_b,val.port_a)
    annotation (Line(points={{-40,60},{-30,60}},color={0,127,255}));
  connect(port_a1,senTDisSup.port_a)
    annotation (Line(points={{-100,60},{-90,60}},color={0,127,255}));
  connect(senTDisSup.port_b,senMasFlo.port_a)
    annotation (Line(points={{-70,60},{-60,60}},color={0,127,255}));
  connect(senTDisRet.port_b,port_b1)
    annotation (Line(points={{90,60},{100,60}},color={0,127,255}));
  connect(con.y,val.y)
    annotation (Line(points={{-69,0},{-20,0},{-20,48}},color={0,0,127}));
  connect(pro.y,cp.u)
    annotation (Line(points={{1,110},{18,110}},color={0,0,127}));
  connect(senMasFlo.m_flow,pro.u2)
    annotation (Line(points={{-50,71},{-50,104},{-22,104}},color={0,0,127}));
  connect(senTDisSup.T,dTDis.u1)
    annotation (Line(points={{-80,71},{-80,122},{-62,122}},color={0,0,127}));
  connect(senTDisRet.T,dTDis.u2)
    annotation (Line(points={{80,71},{80,80},{-70,80},{-70,110},{-62,110}},color={0,0,127}));
  connect(dTDis.y,pro.u1)
    annotation (Line(points={{-39,116},{-22,116}},color={0,0,127}));
  connect(cp.y,int.u)
    annotation (Line(points={{41,110},{58,110}},color={0,0,127}));
  connect(int.y,Q)
    annotation (Line(points={{81,110},{110,110}},color={0,0,127}));
  connect(Q_flow,cp.y)
    annotation (Line(points={{110,150},{50,150},{50,110},{41,110}},color={0,0,127}));
  connect(TSetBuiSup,con.u_s)
    annotation (Line(points={{-120,0},{-92,0}},color={0,0,127}));
  connect(senTBuiSup.port_a,hex.port_b2)
    annotation (Line(points={{-70,-60},{0,-60},{0,-6},{20,-6}},color={0,127,255}));
  connect(senTBuiSup.T,con.u_m)
    annotation (Line(points={{-80,-49},{-80,-12}},color={0,0,127}));
  connect(port_b2,senTBuiSup.port_b)
    annotation (Line(points={{-100,-60},{-90,-60}},color={0,127,255}));
  annotation (
    defaultComponentName="heaEts",
    Icon(
      coordinateSystem(
        preserveAspectRatio=false),
      graphics={
        Rectangle(
          extent={{-100,-56},{100,-64}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-100,64},{100,56}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={175,175,175},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-62,80},{-58,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-22,80},{-18,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{18,80},{22,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{58,80},{62,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,65},{-4,56}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,66},{80,56}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,-55},{-4,-64}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,-54},{80,-64}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,-56},{-4,-64}},
          lineColor={0,0,255},
          pattern=LinePattern.None)}),
    Diagram(
      coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,160}})),
    Documentation(
      info="<html>
      </html>",
      revisions="<html>
  <li>
  August 1, 2020, by Hagar Elarga:<br/>
  First implementation.
  </li>
  </ul>
  </html>"));
end HeatingIndirect_2;