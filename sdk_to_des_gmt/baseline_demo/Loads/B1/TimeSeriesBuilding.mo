within baseline_demo.Loads.B1;
model TimeSeriesBuilding
  "Building model with heating and cooling loads provided as time series"
  extends Buildings.Experimental.DHC.Loads.BaseClasses.PartialBuilding(
    redeclare package Medium=Buildings.Media.Water,
    have_fan=false,
    have_pum=true,
    have_heaWat=true,
    have_chiWat=true,
    have_eleHea=false,
    have_eleCoo=false,
    have_weaBus=false);
  replaceable package Medium2=Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Load side medium";
  parameter String filNam="modelica://baseline_demo/Loads/Resources/Data/B1/modelica.mos"
     "Library path of the file with loads as time series";
  parameter Boolean have_hotWat=false
    "Set to true if SHW load is included in the time series"
    annotation (Evaluate=true,Dialog(group="Configuration"));
  parameter Real facMulHea=1
    "Heating terminal unit multiplier factor"
    annotation (Dialog(enable=have_heaWat,group="Scaling"));
  parameter Real facMulCoo=1
    "Cooling terminal unit scaling factor"
    annotation (Dialog(enable=have_chiWat,group="Scaling"));
  parameter Modelica.Units.SI.Temperature T_aHeaWat_nominal=313.15
     "Heating water inlet temperature at nominal conditions"
    annotation (Dialog(group="Nominal condition",enable=have_heaWat));
  parameter Modelica.Units.SI.Temperature T_bHeaWat_nominal(
    min=273.15,
    displayUnit="degC")=T_aHeaWat_nominal-5
     "Heating water outlet temperature at nominal conditions"
    annotation (Dialog(group="Nominal condition",enable=have_heaWat));
  parameter Modelica.Units.SI.Temperature T_aChiWat_nominal=280.15
     "Chilled water inlet temperature at nominal conditions "
    annotation (Dialog(group="Nominal condition",enable=have_chiWat));
  parameter Modelica.Units.SI.Temperature T_bChiWat_nominal(
    min=273.15,
    displayUnit="degC")=285.15
     "Chilled water outlet temperature at nominal conditions"
    annotation (Dialog(group="Nominal condition",enable=have_chiWat));
  parameter Modelica.Units.SI.Temperature T_aLoaHea_nominal=293.15
     "Load side inlet temperature at nominal conditions in heating mode"
    annotation (Dialog(group="Nominal condition",enable=have_heaWat));
  parameter Modelica.Units.SI.Temperature T_aLoaCoo_nominal=297.15
     "Load side inlet temperature at nominal conditions in cooling mode"
    annotation (Dialog(group="Nominal condition",enable=have_chiWat));
  parameter Modelica.Units.SI.MassFraction w_aLoaCoo_nominal=0.0095
    "Load side inlet humidity ratio at nominal conditions in cooling mode"
    annotation (Dialog(group="Nominal condition",enable=have_chiWat));
  parameter Modelica.Units.SI.MassFlowRate mLoaHea_flow_nominal=QHea_flow_nominal/(cp_air*delTAirHea)
    "Load side mass flow rate at nominal conditions in heating mode"
    annotation (Dialog(group="Nominal condition",enable=have_heaWat));
  parameter Modelica.Units.SI.MassFlowRate mLoaCoo_flow_nominal=-QCoo_flow_nominal/(cp_air*delTAirCoo)
    "Load side mass flow rate at nominal conditions in cooling mode"
    annotation (Dialog(group="Nominal condition",enable=have_chiWat));
  parameter Modelica.Units.SI.TemperatureDifference delTAirCoo(
    min=1)
    "Nominal cooling air temperature difference across the terminal unit heat exchanger";
  parameter Modelica.Units.SI.TemperatureDifference delTAirHea(
    min=1)
    "Nominal heating air temperature difference across the terminal unit heat exchanger";
  parameter Modelica.Units.SI.HeatFlowRate QCoo_flow_nominal(
    max=-Modelica.Constants.eps)=Buildings.Experimental.DHC.Loads.BaseClasses.getPeakLoad(
    string="#Peak space cooling load",
    filNam=Modelica.Utilities.Files.loadResource(filNam))
    "Design cooling heat flow rate (<=0)"
    annotation (Dialog(group="Nominal condition",enable=have_chiWat));
  parameter Modelica.Units.SI.HeatFlowRate QHea_flow_nominal(
    min=Modelica.Constants.eps)=Buildings.Experimental.DHC.Loads.BaseClasses.getPeakLoad(
    string="#Peak space heating load",
    filNam=Modelica.Utilities.Files.loadResource(filNam))
    "Design heating heat flow rate (>=0)"
    annotation (Dialog(group="Nominal condition"));
  parameter Real k(
    min=0)=0.1
    "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(
    min=Modelica.Constants.small)=10
    "Time constant of integrator block";
  parameter Modelica.Units.SI.MassFlowRate mChiWat_flow_nominal=abs(
    QCoo_flow_nominal/cp_default/(T_aChiWat_nominal-T_bChiWat_nominal))
    "Chilled water mass flow rate at nominal conditions (all units)"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.MassFlowRate mHeaWat_flow_nominal=abs(
    QHea_flow_nominal/cp_default/(T_aHeaWat_nominal-T_bHeaWat_nominal))
    "Heating water mass flow rate at nominal conditions (all units)"
    annotation (Dialog(group="Nominal condition"));
  Modelica.Blocks.Sources.CombiTimeTable loa(
    tableOnFile=true,
    tableName="tab1",
    fileName=Modelica.Utilities.Files.loadResource(
      filNam),
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    y(each unit="W"),
    offset={0,0,0},
    columns={2,3,4},
    smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1)
    "Reader for thermal loads (y[1] is cooling load, y[2] is heating load)"
    annotation (Placement(transformation(extent={{-280,-10},{-260,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant minTSet(
    k=293.15,
    y(unit="K",
      displayUnit="degC"))
    "Minimum temperature set point"
    annotation (Placement(transformation(extent={{-280,170},{-260,190}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant maxTSet(
    k=297.15,
    y(unit="K",
      displayUnit="degC"))
    "Maximum temperature set point"
    annotation (Placement(transformation(extent={{-280,210},{-260,230}})));
  replaceable Buildings.Experimental.DHC.Loads.BaseClasses.Validation.BaseClasses.FanCoil2PipeHeating terUniHea(
    k=k,
    Ti=Ti) if have_heaWat
    constrainedby
    Buildings.Experimental.DHC.Loads.BaseClasses.PartialTerminalUnit(
      redeclare package Medium1=Medium,
      redeclare package Medium2=Medium2,
      allowFlowReversal=allowFlowReversal,
      facMul=facMulHea,
      facMulZon=1,
      QHea_flow_nominal=QHea_flow_nominal/facMulHea,
      mLoaHea_flow_nominal=mLoaHea_flow_nominal,
      T_aHeaWat_nominal=T_aHeaWat_nominal,
      T_bHeaWat_nominal=T_bHeaWat_nominal,
      T_aLoaHea_nominal=T_aLoaHea_nominal)
    "Heating terminal unit"
    annotation (Placement(transformation(extent={{70,-34},{90,-14}})));
  Buildings.Experimental.DHC.Loads.BaseClasses.FlowDistribution disFloHea(
    redeclare package Medium=Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=mHeaWat_flow_nominal,
    have_pum=true,
    typCtr=Buildings.Experimental.DHC.Loads.BaseClasses.Types.PumpControlType.ConstantHead,
    dp_nominal=100000,
    nPorts_a1=1,
    nPorts_b1=1) if have_heaWat
    "Heating water distribution system"
    annotation (Placement(transformation(extent={{120,-70},{140,-50}})));
  Buildings.Experimental.DHC.Loads.BaseClasses.FlowDistribution disFloCoo(
    redeclare package Medium=Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=mChiWat_flow_nominal,
    typDis=Buildings.Experimental.DHC.Loads.BaseClasses.Types.DistributionType.ChilledWater,
    have_pum=true,
    typCtr=Buildings.Experimental.DHC.Loads.BaseClasses.Types.PumpControlType.ConstantHead,
    dp_nominal=100000,
    nPorts_b1=1,
    nPorts_a1=1) if have_chiWat
    "Chilled water distribution system"
    annotation (Placement(transformation(extent={{120,-270},{140,-250}})));
  replaceable Buildings.Experimental.DHC.Loads.BaseClasses.Validation.BaseClasses.FanCoil2PipeCooling terUniCoo(
    QHea_flow_nominal=QHea_flow_nominal/facMulHea,
    T_aLoaHea_nominal=T_aLoaHea_nominal,
    k=k,
    Ti=Ti,
    TRooHea_nominal=T_aLoaHea_nominal,
    QRooHea_flow_nominal=QHea_flow_nominal/facMulCoo) if have_chiWat
    constrainedby
    Buildings.Experimental.DHC.Loads.BaseClasses.PartialTerminalUnit(
      redeclare package Medium1=Medium,
      redeclare package Medium2=Medium2,
      allowFlowReversal=allowFlowReversal,
      facMul=facMulCoo,
      facMulZon=1,
      QCoo_flow_nominal=QCoo_flow_nominal/facMulCoo,
      mLoaCoo_flow_nominal=mLoaCoo_flow_nominal,
      T_aChiWat_nominal=T_aChiWat_nominal,
      T_bChiWat_nominal=T_bChiWat_nominal,
      T_aLoaCoo_nominal=T_aLoaCoo_nominal,
      w_aLoaCoo_nominal=w_aLoaCoo_nominal)
    "Cooling terminal unit"
    annotation (Placement(transformation(extent={{70,26},{90,46}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput QReqHotWat_flow(
    unit="W") if have_hotWat
    "SHW load"
    annotation (Placement(transformation(extent={{300,-140},{340,-100}}),iconTransformation(extent={{-40,-40},{40,40}},rotation=-90,origin={280,-340})));
  Modelica.Blocks.Interfaces.RealOutput QReqHea_flow(
    quantity="HeatFlowRate",
    unit="W") if have_heaLoa
    "Heating load"
    annotation (Placement(transformation(extent={{300,20},{340,60}}),iconTransformation(extent={{-20,-20},{20,20}},rotation=-90,origin={200,-320})));
  Modelica.Blocks.Interfaces.RealOutput QReqCoo_flow(
    quantity="HeatFlowRate",
    unit="W") if have_cooLoa
    "Cooling load"
    annotation (Placement(transformation(extent={{300,-20},{340,20}}),iconTransformation(extent={{-20,-20},{20,20}},rotation=-90,origin={260,-320})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant noHea(
    k=0) if not have_heaWat
    "No heating system"
    annotation (Placement(transformation(extent={{80,120},{100,140}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant noCoo(
    k=0) if not have_chiWat
    "No cooling system"
    annotation (Placement(transformation(extent={{80,78},{100,98}})));
  Buildings.Controls.OBC.CDL.Continuous.Add addPFan
    "Sum fan power"
    annotation (Placement(transformation(extent={{222,120},{242,140}})));
  Buildings.Controls.OBC.CDL.Continuous.Add addPPum
    "Sum pump power"
    annotation (Placement(transformation(extent={{222,70},{242,90}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiplyByParameter mulQReqHea_flow(
    u(unit="W"),
    k=facMul) if have_heaLoa
    "Scaling"
    annotation (Placement(transformation(extent={{272,30},{292,50}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiplyByParameter mulQReqCoo_flow(
    u(unit="W"),
    k=facMul) if have_cooLoa
    "Scaling"
    annotation (Placement(transformation(extent={{272,-10},{292,10}})));
protected
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_air=1005
    "Air specific heat capacity";
  parameter Modelica.Units.SI.SpecificHeatCapacity cpHeaWat_nominal=Medium.specificHeatCapacityCp(
    Medium.setState_pTX(
      Medium.p_default,
      T_aHeaWat_nominal))
    "Heating water specific heat capacity at nominal conditions";
  parameter Modelica.Units.SI.SpecificHeatCapacity cpChiWat_nominal=Medium.specificHeatCapacityCp(
    Medium.setState_pTX(
      Medium.p_default,
      T_aChiWat_nominal))
    "Chilled water specific heat capacity at nominal conditions";
equation
  connect(terUniHea.port_bHeaWat,disFloHea.ports_a1[1])
    annotation (Line(points={{90,-32.3333},{90,-32},{146,-32},{146,-54},{140,
          -54}},                                                                   color={0,127,255}));
  connect(disFloHea.ports_b1[1],terUniHea.port_aHeaWat)
    annotation (Line(points={{120,-54},{64,-54},{64,-32.3333},{70,-32.3333}},color={0,127,255}));
  connect(terUniHea.mReqHeaWat_flow,disFloHea.mReq_flow[1])
    annotation (Line(points={{90.8333,-27.3333},{90.8333,-28},{100,-28},{100,
          -64},{119,-64}},                                                                   color={0,0,127}));
  connect(disFloHea.QActTot_flow,QHea_flow)
    annotation (Line(points={{141,-66},{260,-66},{260,280},{320,280}},color={0,0,127}));
  connect(disFloCoo.QActTot_flow,QCoo_flow)
    annotation (Line(points={{141,-266},{268,-266},{268,240},{320,240}},color={0,0,127}));
  connect(loa.y[1],terUniCoo.QReqCoo_flow)
    annotation (Line(points={{-259,0},{46,0},{46,32.5},{69.1667,32.5}},
                                                                     color={0,0,127}));
  connect(loa.y[2],terUniHea.QReqHea_flow)
    annotation (Line(points={{-259,0},{46,0},{46,-25.6667},{69.1667,-25.6667}},
                                                                             color={0,0,127}));
  connect(disFloCoo.ports_b1[1],terUniCoo.port_aChiWat)
    annotation (Line(points={{120,-254},{60,-254},{60,29.3333},{70,29.3333}},color={0,127,255}));
  connect(terUniCoo.port_bChiWat,disFloCoo.ports_a1[1])
    annotation (Line(points={{90,29.3333},{112,29.3333},{160,29.3333},{160,-254},
          {140,-254}},                                                                       color={0,127,255}));
  connect(terUniCoo.mReqChiWat_flow,disFloCoo.mReq_flow[1])
    annotation (Line(points={{90.8333,31},{108,31},{108,-264},{119,-264}},color={0,0,127}));
  connect(minTSet.y,terUniHea.TSetHea)
    annotation (Line(points={{-258,180},{-20,180},{-20,-20},{24,-20},{24,-19},{
          69.1667,-19}},                                                                     color={0,0,127}));
  connect(maxTSet.y,terUniCoo.TSetCoo)
    annotation (Line(points={{-258,220},{0,220},{0,39.3333},{69.1667,39.3333}},color={0,0,127}));
  connect(loa.y[1],QReqCoo_flow)
    annotation (Line(points={{-259,0},{320,0},{320,0}},
                                                     color={0,0,127}));
  connect(loa.y[2],QReqHea_flow)
    annotation (Line(points={{-259,0},{280,0},{280,40},{320,40}},
                                                               color={0,0,127}));
  connect(loa.y[1],mulQReqCoo_flow.u)
    annotation (Line(points={{-259,0},{270,0}},color={0,0,127}));
  connect(loa.y[2],mulQReqHea_flow.u)
    annotation (Line(points={{-259,0},{260,0},{260,40},{270,40}},color={0,0,127}));
  connect(loa.y[3],QReqHotWat_flow)
    annotation (Line(points={{-259,0},{40,0},{40,-120},{320,-120}},color={0,0,127}));
  connect(disFloHea.PPum,addPPum.u1)
    annotation (Line(points={{141,-68},{170,-68},{170,86},{220,86}},color={0,0,127}));
  connect(disFloCoo.PPum,addPPum.u2)
    annotation (Line(points={{141,-268},{200,-268},{200,74},{220,74}},color={0,0,127}));
  connect(addPPum.y,PPum)
    annotation (Line(points={{244,80},{320,80}},color={0,0,127}));
  connect(noHea.y,addPPum.u1)
    annotation (Line(points={{102,130},{170,130},{170,86},{220,86}},color={0,0,127}));
  connect(noCoo.y,addPPum.u2)
    annotation (Line(points={{102,88},{200,88},{200,74},{220,74}},color={0,0,127}));
  connect(addPFan.y,PFan)
    annotation (Line(points={{244,130},{282,130},{282,120},{320,120}},color={0,0,127}));
  connect(noHea.y,addPFan.u1)
    annotation (Line(points={{102,130},{200,130},{200,136},{220,136}},color={0,0,127}));
  connect(noCoo.y,addPFan.u2)
    annotation (Line(points={{102,88},{200,88},{200,124},{220,124}},color={0,0,127}));
  connect(terUniCoo.PFan,addPFan.u2)
    annotation (Line(points={{90.8333,36},{160,36},{160,124},{220,124}},color={0,0,127}));
  connect(terUniHea.PFan,addPFan.u1)
    annotation (Line(points={{90.8333,-24},{180,-24},{180,136},{220,136}},color={0,0,127}));
  connect(disFloHea.port_b, mulHeaWatOut.port_a)
    annotation (Line(points={{140,-60},{260,-60}}, color={0,127,255}));
  connect(disFloCoo.port_b, mulChiWatOut.port_a)
    annotation (Line(points={{140,-260},{260,-260}}, color={0,127,255}));
  connect(disFloCoo.port_a, mulChiWatInl.port_b)
    annotation (Line(points={{120,-260},{-260,-260}}, color={0,127,255}));
  connect(disFloHea.port_a, mulHeaWatInl.port_b)
    annotation (Line(points={{120,-60},{-260,-60}}, color={0,127,255}));
  annotation (
    Documentation(
      info="
<html>
<p>
This is a simplified building model where the space heating and cooling loads
are provided as time series.
</p>
</html>",
      revisions="<html>
<ul>
<li>
October 20, 2020, by Hagar Elarga:<br/>
The <code>mLoaHea_flow_nominal</code> and <code>mLoaCoo_flow_nominal</code> are
evaluated as a function of <code> QHea_flow_nominal</code> and
<code>QCoo_flow_nominal</code> respectively.
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2201\">issue 2201</a> and
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2202\">issue 2202</a>.
</li>
<li>
September 18, 2020, by Jianjun Hu:<br/>
Changed flow distribution components and the terminal units to be conditional depending
on if there is water-based heating, or cooling system.
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2147\">issue 2147</a>.
</li>
<li>
February 21, 2020, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        extent={{-300,-300},{300,300}})));
end TimeSeriesBuilding;
