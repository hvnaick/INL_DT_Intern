within ;
package INL_DT
  package Tests
    model NCFL_Modular

      replaceable package Medium = Modelica.Media.Water.StandardWater                             annotation (
         choicesAllMatching=true);
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Medium,
        p=ncfl.data.Init_P,
        T=ncfl.data.Init_T,
        nPorts=1)
        annotation (Placement(transformation(extent={{76,-14},{56,6}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T SecondaryLoop(
        redeclare package Medium = Medium,
        m_flow=20,
        nPorts=1)
        annotation (Placement(transformation(extent={{72,28},{52,48}})));
      Components.NCFL ncfl(redeclare INL_DT.ControlSystems.RegularCS CS,
                           redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-60,-16},{0,38}})));
    equation
      connect(SecondaryLoop.ports[1], ncfl.port_b) annotation (Line(points={{52,
              38},{6,38},{6,15.9091},{-21.12,15.9091}}, color={0,127,255}));
      connect(boundary1.ports[1], ncfl.port_a) annotation (Line(points={{56,-4},
              {6,-4},{6,7.80909},{-21.12,7.80909}}, color={0,127,255}));
      annotation (experiment(StartTime=0, StopTime=180, Interval=0.1), Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end NCFL_Modular;

    model NCFL_Total
      replaceable package Medium = Modelica.Media.Water.StandardWater                             annotation (
         choicesAllMatching=true);

      BaseClasses.Data_NCFL data(Heater_Length=1.5446375/3, Thermal_Cond=35)
        annotation (Placement(transformation(extent={{154,98},{174,118}})));
      Modelica.Fluid.Pipes.StaticPipe Slant(
        redeclare package Medium = Medium,
        length=data.Slant_Pipe_L,
        diameter=data.Pipe_D,
        height_ab=data.Slant,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01)
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
      Modelica.Fluid.Pipes.StaticPipe Distance2Heaters(
        redeclare package Medium = Medium,
        length=0.6016625,
        diameter=data.Pipe_D,
        height_ab=0.6016625,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,-64})));
      Modelica.Fluid.Pipes.StaticPipe PumpPipe(
        redeclare package Medium = Medium,
        length=1.252,
        diameter=data.Pipe_D,
        height_ab=0.3,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={70,-170})));
      TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package
          Medium =
            Medium,
        use_input=true,
        m_flow_nominal=data.Pump_Mflow,
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{46,-180},{26,-160}})));
      Modelica.Fluid.Pipes.StaticPipe DistanceAfterHX(
        redeclare package Medium = Medium,
        length=data.Height,
        diameter=data.Pipe_D,
        height_ab=-4,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={86,-60})));
      replaceable package Medium_shell = Medium
        annotation (choicesAllMatching=true);
      replaceable package Medium_tube = Medium
        annotation (choicesAllMatching=true);

      TRANSFORM.Fluid.Volumes.MixingVolume volume(
        redeclare package Medium = Medium,
        p_start=data.Init_P,
        T_start=data.Init_T,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume,
        nPorts_a=1,
        nPorts_b=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={86,-98})));

      NHES.Fluid.Sensors.stateSensor s1(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,-96})));
      NHES.Fluid.Sensors.stateDisplay stateDisplay
        annotation (Placement(transformation(extent={{-134,-112},{-80,-82}})));
      NHES.Fluid.Sensors.stateSensor s2(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,86})));
      NHES.Fluid.Sensors.stateSensor s3(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={86,64})));
      NHES.Fluid.Sensors.stateSensor s4(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={86,-124})));
      NHES.Fluid.Sensors.stateDisplay stateDisplay1
        annotation (Placement(transformation(extent={{-134,82},{-80,112}})));
      NHES.Fluid.Sensors.stateDisplay stateDisplay2
        annotation (Placement(transformation(extent={{116,62},{170,92}})));
      NHES.Fluid.Sensors.stateDisplay stateDisplay3
        annotation (Placement(transformation(extent={{108,-110},{162,-80}})));
      Modelica.Fluid.Pipes.StaticPipe V1_Inlet(
        redeclare package Medium = Medium,
        length=0.1905,
        diameter=data.Pipe_D,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={38,-142})));
      Modelica.Fluid.Valves.ValveIncompressible V_top(
        redeclare package Medium = Medium,
        dp_nominal=data.Init_P,
        m_flow_nominal=data.Pump_Mflow/2)
        annotation (Placement(transformation(extent={{12,-152},{-8,-132}})));
      Modelica.Fluid.Valves.ValveIncompressible V_bot(
        redeclare package Medium = Medium,
        dp_nominal=data.Init_P,
        m_flow_nominal=data.Pump_Mflow/2)
        annotation (Placement(transformation(extent={{4,-180},{-16,-160}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=stateDisplay1.T)
        annotation (Placement(transformation(extent={{-210,20},{-190,40}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=-stateDisplay.T)
        annotation (Placement(transformation(extent={{-210,-6},{-190,14}})));
      Modelica.Blocks.Sources.Constant const(k=1)
        annotation (Placement(transformation(extent={{-20,-60},{-26,-54}})));
      Modelica.Blocks.Math.Add T_diff
        annotation (Placement(transformation(extent={{-152,10},{-132,30}})));
      Modelica.Fluid.Pipes.StaticPipe JetInlet(
        redeclare package Medium = Medium,
        length=0.254,
        diameter=data.JetPump_D,
        height_ab=0.254,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-9},{10,9}},
            rotation=90,
            origin={-63,-158})));
      Modelica.Fluid.Pipes.StaticPipe DistanceAfterHeaters(
        redeclare package Medium = Medium,
        length=data.Height,
        diameter=data.Pipe_D,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,60})));
      Components.Heater heater3(
        HeaterLength=data.Heater_Length,
        HeaterRadius=data.Heater_radius,
        HeaterPower=data.Heater_Power) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-62,30})));
      Components.Heater heater2(
        HeaterLength=data.Heater_Length,
        HeaterRadius=data.Heater_radius,
        HeaterPower=data.Heater_Power) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-62,0})));
      Components.Heater heater1(
        HeaterLength=data.Heater_Length,
        HeaterRadius=data.Heater_radius,
        HeaterPower=data.Heater_Power) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-62,-34})));
      Modelica.Fluid.Pipes.StaticPipe JetSuction(
        redeclare package Medium = Medium,
        length=0.36195,
        diameter=data.Pipe_D,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-34,-142})));
      Modelica.Fluid.Pipes.StaticPipe ValveOutlet(
        redeclare package Medium = Medium,
        length=0.4572,
        diameter=data.Pipe_D,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-34,-170})));
      Modelica.Fluid.Pipes.StaticPipe JetPump(
        redeclare package Medium = Medium,
        length=data.JetPump_L,
        diameter=data.JetPump_D,
        height_ab=data.JetPump_L,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-9},{10,9}},
            rotation=90,
            origin={-65,-126})));
      Components.HX_Isolated HX(
        HXLength=data.HX_L,
        HXRadius=data.HX_radius,
        HX_Transfer=-10E3,
        Therm_cond=data.Thermal_Cond)
                           annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={88,26})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=-stateDisplay2.T)
        annotation (Placement(transformation(extent={{-212,-30},{-192,-10}})));
      Modelica.Blocks.Sources.RealExpression realExpression3(y=stateDisplay3.T)
        annotation (Placement(transformation(extent={{-212,-56},{-192,-36}})));
      Modelica.Blocks.Math.Add T_diff1
        annotation (Placement(transformation(extent={{-154,-40},{-134,-20}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Medium,
        p=data.Init_P,
        T=data.Init_T,
        nPorts=1)
        annotation (Placement(transformation(extent={{200,48},{180,68}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T SecondaryLoop(
        redeclare package Medium = Medium,
        m_flow=20,
        nPorts=1)
        annotation (Placement(transformation(extent={{208,-16},{188,4}})));
      Modelica.Blocks.Sources.Ramp ramp(
        height=data.Pump_Mflow,
        duration=20,
        startTime=100)
        annotation (Placement(transformation(extent={{-20,-98},{-8,-86}})));
    equation
      connect(DistanceAfterHX.port_b, volume.port_a[1])
        annotation (Line(points={{86,-70},{86,-92}}, color={0,127,255}));
      connect(Distance2Heaters.port_a, s1.port_b)
        annotation (Line(points={{-64,-74},{-64,-86}},  color={0,127,255}));
      connect(s2.port_b, Slant.port_a) annotation (Line(points={{-64,96},{-64,100},
              {-10,100}}, color={0,127,255}));
      connect(Slant.port_b, s3.port_a)
        annotation (Line(points={{10,100},{86,100},{86,74}}, color={0,127,255}));
      connect(volume.port_b[1], s4.port_a)
        annotation (Line(points={{86,-104},{86,-114}}, color={0,127,255}));
      connect(s1.statePort, stateDisplay.statePort) annotation (Line(points={{-64.05,
              -95.95},{-52,-95.95},{-52,-108},{-70,-108},{-70,-120},{-107,-120},{-107,
              -100.9}},                                                     color
            ={0,0,0}));
      connect(s2.statePort, stateDisplay1.statePort) annotation (Line(points={{-64.05,
              86.05},{-64.05,98},{-78,98},{-78,76},{-107,76},{-107,93.1}}, color=
              {0,0,0}));
      connect(s3.statePort, stateDisplay2.statePort) annotation (Line(points={{
              85.95,63.95},{110,63.95},{110,56},{143,56},{143,73.1}}, color={0,0,
              0}));
      connect(s4.statePort, stateDisplay3.statePort) annotation (Line(points={{
              85.95,-124.05},{135,-124.05},{135,-98.9}}, color={0,0,0}));
      connect(V1_Inlet.port_a, s4.port_b) annotation (Line(points={{48,-142},{86,-142},
              {86,-134}}, color={0,127,255}));
      connect(V1_Inlet.port_b, V_top.port_a)
        annotation (Line(points={{28,-142},{12,-142}}, color={0,127,255}));
      connect(realExpression.y, T_diff.u1) annotation (Line(points={{-189,30},{
              -164,30},{-164,26},{-154,26}}, color={0,0,127}));
      connect(realExpression1.y, T_diff.u2) annotation (Line(points={{-189,4},{
              -162,4},{-162,14},{-154,14}}, color={0,0,127}));
      connect(DistanceAfterHeaters.port_b, s2.port_a)
        annotation (Line(points={{-64,70},{-64,76}}, color={0,127,255}));
      connect(heater3.port_b, DistanceAfterHeaters.port_a) annotation (Line(
            points={{-63,40},{-63,44},{-64,44},{-64,50}}, color={0,127,255}));
      connect(heater2.port_b, heater3.port_a)
        annotation (Line(points={{-63,10},{-63,20}}, color={0,127,255}));
      connect(Distance2Heaters.port_b, heater1.port_a) annotation (Line(points={{
              -64,-54},{-64,-48},{-63,-48},{-63,-44}}, color={0,127,255}));
      connect(heater1.port_b, heater2.port_a)
        annotation (Line(points={{-63,-24},{-63,-10}}, color={0,127,255}));
      connect(V_top.port_b, JetSuction.port_a)
        annotation (Line(points={{-8,-142},{-24,-142}}, color={0,127,255}));
      connect(JetInlet.port_a, ValveOutlet.port_b) annotation (Line(points={{-63,-168},
              {-63,-170},{-44,-170}}, color={0,127,255}));
      connect(ValveOutlet.port_a, V_bot.port_b)
        annotation (Line(points={{-24,-170},{-16,-170}}, color={0,127,255}));
      connect(JetInlet.port_b, JetPump.port_a) annotation (Line(points={{-63,-148},{
              -63,-144},{-65,-144},{-65,-136}}, color={0,127,255}));
      connect(JetSuction.port_b, JetPump.port_a) annotation (Line(points={{-44,-142},
              {-65,-142},{-65,-136}}, color={0,127,255}));
      connect(JetPump.port_b, s1.port_a) annotation (Line(points={{-65,-116},{-65,-111},
              {-64,-111},{-64,-106}}, color={0,127,255}));
      connect(pump.port_b, V_bot.port_a)
        annotation (Line(points={{26,-170},{4,-170}}, color={0,127,255}));
      connect(pump.port_a, PumpPipe.port_b)
        annotation (Line(points={{46,-170},{60,-170}}, color={0,127,255}));
      connect(PumpPipe.port_a, s4.port_b) annotation (Line(points={{80,-170},{86,-170},
              {86,-134}}, color={0,127,255}));
      connect(s3.port_b, HX.port_a) annotation (Line(points={{86,54},{86,45},{
              86.2,45},{86.2,36}}, color={0,127,255}));
      connect(HX.port_b, DistanceAfterHX.port_a) annotation (Line(points={{86.2,
              16},{86.2,-17},{86,-17},{86,-50}}, color={0,127,255}));
      connect(realExpression2.y, T_diff1.u1) annotation (Line(points={{-191,-20},
              {-166,-20},{-166,-24},{-156,-24}},
                                       color={0,0,127}));
      connect(realExpression3.y, T_diff1.u2) annotation (Line(points={{-191,-46},
              {-164,-46},{-164,-36},{-156,-36}},
                                             color={0,0,127}));
      connect(SecondaryLoop.ports[1], HX.port_a1) annotation (Line(points={{188,
              -6},{92,-6},{92,16}}, color={0,127,255}));
      connect(HX.port_b1, boundary1.ports[1]) annotation (Line(points={{92,36},
              {92,44},{174,44},{174,42},{180,42},{180,58}}, color={0,127,255}));
      connect(ramp.y, pump.in_m_flow) annotation (Line(points={{-7.4,-92},{22,
              -92},{22,-154},{20,-154},{20,-162.7},{36,-162.7}}, color={0,0,127}));
      connect(const.y, V_top.opening) annotation (Line(points={{-26.3,-57},{2,
              -57},{2,-134}}, color={0,0,127}));
      connect(const.y, V_bot.opening) annotation (Line(points={{-26.3,-57},{
              -26.3,-58},{2,-58},{2,-126},{18,-126},{18,-162},{-6,-162}}, color
            ={0,0,127}));
      annotation (experiment(StartTime=0, StopTime=180, Interval=0.1), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
                -200},{300,120}})),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-220,-200},{300,
                120}})));
    end NCFL_Total;
  end Tests;

  package Components
    model Heater

      parameter Real bruh = 10;
      parameter Modelica.Units.SI.Length HeaterLength = 0;
      parameter Modelica.Units.SI.Length HeaterRadius = 0;
      parameter Modelica.Units.SI.Pressure Init_P = 101325;
      parameter Modelica.Units.SI.Power HeaterPower = 0;
      parameter Boolean allowFlowReversal = false;



      replaceable package Medium = Modelica.Media.Water.StandardWater                             annotation (
         choicesAllMatching=true);

      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Heater(
        allowFlowReversal=false,
        redeclare package Medium = Medium,
        m_flow_a_start=20,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
            (crossAreas=fill(Modelica.Constants.pi*HeaterRadius^2, 1),
              perimeters=fill(Modelica.Constants.pi*2*HeaterRadius, 1)),
        redeclare model FlowModel =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable
            (m_flow_small=15),
        use_HeatTransfer=true) annotation (Placement(transformation(
            extent={{5,-5},{-5,5}},
            rotation=180,
            origin={-7,13})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow HeatSRC(Q_flow=
            HeaterPower) annotation (Placement(transformation(
            extent={{5,5},{-5,-5}},
            rotation=-90,
            origin={-7,-9})));
      Modelica.Fluid.Pipes.StaticPipe HeaterPipe(
        redeclare package Medium = Medium,
        length=HeaterLength,
        diameter=HeaterRadius*2,
        p_a_start=Init_P,
        m_flow_start=20)   annotation (Placement(transformation(
            extent={{4,-5},{-4,5}},
            rotation=180,
            origin={-33,12})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow
                                port_a(redeclare package Medium = Medium, m_flow(
            min=if allowFlowReversal then -Modelica.Constants.inf else 0))
        annotation (Placement(transformation(extent={{-110,0},{-90,20}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State
                                 port_b(redeclare package Medium = Medium, m_flow(
            max=if allowFlowReversal then +Modelica.Constants.inf else 0))
        annotation (Placement(transformation(extent={{90,0},{110,20}})));
    equation
      connect(Heater.heatPorts[1, 1], HeatSRC.port)
        annotation (Line(points={{-7,10.5},{-7,-4}}, color={191,0,0}));
      connect(HeaterPipe.port_b, Heater.port_a)
        annotation (Line(points={{-29,12},{-29,13},{-12,13}}, color={0,127,255}));
      connect(port_a, HeaterPipe.port_a) annotation (Line(points={{-100,10},{-98,10},
              {-98,12},{-37,12}}, color={0,127,255}));
      connect(Heater.port_b, port_b) annotation (Line(points={{-2,13},{84,13},{84,10},
              {100,10}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Heater;

    model JetPump
      parameter Modelica.Units.SI.Length SuctionRadius = 0;
      parameter Modelica.Units.SI.Length InletRadius = 0;
      parameter Modelica.Units.SI.Length DiffuserRadius = 0;
      parameter Boolean allowFlowReversal = false;

      replaceable package Medium = Modelica.Media.Water.StandardWater                             annotation (
         choicesAllMatching=true);

      Modelica.Fluid.Interfaces.FluidPort_a InletPort
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_a SuctionPort
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Fluid.Interfaces.FluidPort_b DischargePort
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
      Modelica.Fluid.Pipes.StaticPipe Inlet annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-62})));
      Modelica.Fluid.Pipes.StaticPipe Suction annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={58,0})));
      Modelica.Fluid.Pipes.StaticPipe Nozzle annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,26})));
      Modelica.Fluid.Pipes.StaticPipe Diffuser annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,72})));
    equation
      connect(InletPort, Inlet.port_a) annotation (Line(points={{0,-100},{0,-86},{-5.55112e-16,
              -86},{-5.55112e-16,-72}}, color={0,127,255}));
      connect(SuctionPort, Suction.port_a) annotation (Line(points={{100,0},{84,0},{
              84,-1.72085e-15},{68,-1.72085e-15}}, color={0,127,255}));
      connect(Inlet.port_b, Nozzle.port_a) annotation (Line(points={{6.10623e-16,-52},
              {6.10623e-16,-18},{-5.55112e-16,-18},{-5.55112e-16,16}}, color={0,127,
              255}));
      connect(Suction.port_b, Nozzle.port_a) annotation (Line(points={{48,7.21645e-16},
              {-5.55112e-16,7.21645e-16},{-5.55112e-16,16}}, color={0,127,255}));
      connect(Nozzle.port_b, Diffuser.port_a) annotation (Line(points={{6.10623e-16,
              36},{6.10623e-16,49},{-5.55112e-16,49},{-5.55112e-16,62}}, color={0,127,
              255}));
      connect(Diffuser.port_b, DischargePort) annotation (Line(points={{6.10623e-16,
              82},{6.10623e-16,91},{0,91},{0,100}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end JetPump;

    model HX_Isolated

      parameter Modelica.Units.SI.Length HXLength = 0;
      parameter Modelica.Units.SI.Length HXRadius = 0;
      parameter Modelica.Units.SI.Pressure Init_P = 101325;
      parameter Modelica.Units.SI.Power HX_Transfer = 0;
      parameter Real Therm_cond = 0;
      parameter Boolean allowFlowReversal = false;

      replaceable package Medium = Modelica.Media.Water.StandardWater                             annotation (
         choicesAllMatching=true);
      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Shell(
        allowFlowReversal=false,
        redeclare package Medium = Medium,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
            (crossAreas=fill(Modelica.Constants.pi*HXRadius^2, 1), perimeters=
                fill(Modelica.Constants.pi*2*HXRadius, 1)),
        use_HeatTransfer=true,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal,
        redeclare model InternalHeatGen =
            TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration)
        annotation (Placement(transformation(
            extent={{5,-5},{-5,5}},
            rotation=180,
            origin={-7,21})));

      Modelica.Fluid.Pipes.StaticPipe HXPipe(
        redeclare package Medium = Medium,
        length=HXLength,
        diameter=HXRadius*2,
        p_a_start=Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{4,-5},{-4,5}},
            rotation=180,
            origin={-33,20})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow
                                port_a(redeclare package Medium = Medium, m_flow(
            min=if allowFlowReversal then -Modelica.Constants.inf else 0))
        annotation (Placement(transformation(extent={{-110,8},{-90,28}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State
                                 port_b(redeclare package Medium = Medium, m_flow(
            max=if allowFlowReversal then +Modelica.Constants.inf else 0))
        annotation (Placement(transformation(extent={{90,8},{110,28}})));
      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder cylinder(
        L=HXLength,
        r_in=HXRadius,
        r_out=HXRadius*2 + 0.04,
        lambda=Therm_cond) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-6,-8})));
      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Tube(
        allowFlowReversal=false,
        redeclare package Medium = Medium,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
            (crossAreas=fill(Modelica.Constants.pi*HXRadius^2, 1), perimeters=
                fill(Modelica.Constants.pi*2*HXRadius, 1)),
        use_HeatTransfer=true,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal,
        redeclare model InternalHeatGen =
            TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration)
        annotation (Placement(transformation(
            extent={{-5,5},{5,-5}},
            rotation=180,
            origin={-7,-35})));

      TRANSFORM.Fluid.Interfaces.FluidPort_Flow
                                port_a1(redeclare package Medium = Medium,
          m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
        annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State
                                 port_b1(redeclare package Medium = Medium,
          m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
        annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
      Modelica.Fluid.Pipes.StaticPipe HXTube(
        redeclare package Medium = Medium,
        length=HXLength,
        diameter=HXRadius*2,
        p_a_start=Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-4,-5},{4,5}},
            rotation=180,
            origin={-41,-34})));
      TRANSFORM.Fluid.Sensors.Temperature InletS_Shell(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
      TRANSFORM.Fluid.Sensors.Temperature OutletS_Shell(redeclare package
          Medium = Medium)
        annotation (Placement(transformation(extent={{26,20},{46,40}})));
      TRANSFORM.Fluid.Sensors.Temperature OutletS_Tube(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-72,-34},{-52,-14}})));
      TRANSFORM.Fluid.Sensors.Temperature InletS_Tube(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{26,-36},{46,-16}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=InletS_Shell.T)
        annotation (Placement(transformation(extent={{-134,72},{-114,92}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=-OutletS_Shell.T)
        annotation (Placement(transformation(extent={{-134,46},{-114,66}})));
      Modelica.Blocks.Math.Add T_diff
        annotation (Placement(transformation(extent={{-76,62},{-56,82}})));
    equation
      connect(HXPipe.port_b, Shell.port_a) annotation (Line(points={{-29,20},{-29,
              21},{-12,21}}, color={0,127,255}));
      connect(port_a, HXPipe.port_a) annotation (Line(points={{-100,18},{-98,18},{-98,
              20},{-37,20}}, color={0,127,255}));
      connect(Shell.heatPorts[1, 1], cylinder.port_a) annotation (Line(points={
              {-7,18.5},{-7,9.25},{-6,9.25},{-6,-1}}, color={191,0,0}));
      connect(Tube.heatPorts[1, 1], cylinder.port_b) annotation (Line(points={{
              -7,-32.5},{-7,-25.25},{-6,-25.25},{-6,-15}}, color={191,0,0}));
      connect(Tube.port_b, HXTube.port_a) annotation (Line(points={{-12,-35},{
              -24.5,-35},{-24.5,-34},{-37,-34}}, color={0,127,255}));
      connect(Tube.port_a, port_a1) annotation (Line(points={{-2,-35},{-2,-36},
              {84,-36},{84,-40},{100,-40}}, color={0,127,255}));
      connect(HXTube.port_b, port_b1) annotation (Line(points={{-45,-34},{-84,
              -34},{-84,-40},{-100,-40}}, color={0,127,255}));
      connect(port_a, InletS_Shell.port) annotation (Line(points={{-100,18},{
              -98,18},{-98,20},{-60,20}}, color={0,127,255}));
      connect(Shell.port_b, OutletS_Shell.port) annotation (Line(points={{-2,21},
              {17,21},{17,20},{36,20}}, color={0,127,255}));
      connect(OutletS_Shell.port, port_b) annotation (Line(points={{36,20},{36,
              18},{100,18}}, color={0,127,255}));
      connect(HXTube.port_b, OutletS_Tube.port)
        annotation (Line(points={{-45,-34},{-62,-34}}, color={0,127,255}));
      connect(Tube.port_a, InletS_Tube.port) annotation (Line(points={{-2,-35},
              {-2,-36},{36,-36}}, color={0,127,255}));
      connect(realExpression.y,T_diff. u1) annotation (Line(points={{-113,82},{
              -88,82},{-88,78},{-78,78}},    color={0,0,127}));
      connect(realExpression1.y,T_diff. u2) annotation (Line(points={{-113,56},
              {-86,56},{-86,66},{-78,66}},  color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end HX_Isolated;

    model JetPump_Claude
      "Physical jet pump (ejector) model with nozzle, mixing chamber, and diffuser"

      // ── Medium ──────────────────────────────────────────────────────────────
      replaceable package Medium = Modelica.Media.Water.StandardWater
        constrainedby Modelica.Media.Interfaces.PartialMedium
        annotation(choicesAllMatching = true);

      // ── Fluid ports ─────────────────────────────────────────────────────────
      Modelica.Fluid.Interfaces.FluidPort_a port_motive(
        redeclare package Medium = Medium)
        "Motive (primary, high-pressure) inlet"
        annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));

      Modelica.Fluid.Interfaces.FluidPort_a port_suction(
        redeclare package Medium = Medium)
        "Suction (secondary, low-pressure) inlet"
        annotation(Placement(transformation(extent={{-10,-110},{10,-90}})));

      Modelica.Fluid.Interfaces.FluidPort_b port_discharge(
        redeclare package Medium = Medium)
        "Discharge (combined flow) outlet"
        annotation(Placement(transformation(extent={{90,-10},{110,10}})));

      // ── Geometry parameters ─────────────────────────────────────────────────
      parameter Modelica.Units.SI.Diameter d_nozzle   = 0.020
        "Motive nozzle exit diameter";
      parameter Modelica.Units.SI.Diameter d_throat    = 0.030
        "Mixing chamber (throat) diameter";
      parameter Modelica.Units.SI.Diameter d_diffuser  = 0.050
        "Diffuser outlet diameter";
      parameter Modelica.Units.SI.Length   L_mixing    = 0.150
        "Mixing chamber length";
      parameter Modelica.Units.SI.Length   L_diffuser  = 0.300
        "Diffuser length";
      parameter Modelica.Units.SI.Angle    alpha_diff  = 0.122
        "Diffuser half-angle [rad] (~7 deg)";

      // ── Loss coefficients ────────────────────────────────────────────────────
      parameter Real Cd_nozzle  = 0.95  "Motive nozzle discharge coefficient [-]";
      parameter Real Kp         = 0.05  "Primary nozzle loss coefficient [-]";
      parameter Real Ks         = 0.10  "Suction inlet loss coefficient [-]";
      parameter Real Km         = 0.15  "Mixing chamber loss coefficient [-]";
      parameter Real Kd         = 0.20  "Diffuser loss coefficient [-]";

      // ── Derived geometry ─────────────────────────────────────────────────────
      final parameter Modelica.Units.SI.Area A_nozzle  =
          Modelica.Constants.pi / 4 * d_nozzle^2   "Nozzle exit area";
      final parameter Modelica.Units.SI.Area A_throat  =
          Modelica.Constants.pi / 4 * d_throat^2   "Throat (mixing) area";
      final parameter Modelica.Units.SI.Area A_diff_out =
          Modelica.Constants.pi / 4 * d_diffuser^2 "Diffuser outlet area";
      final parameter Real R = A_nozzle / A_throat  "Nozzle-to-throat area ratio";

      // ── Internal state variables ─────────────────────────────────────────────
      // --- Pressures ---
      Modelica.Units.SI.Pressure Pp(start=5e5)  "Motive inlet pressure";
      Modelica.Units.SI.Pressure Ps(start=1e5)  "Suction inlet pressure";
      Modelica.Units.SI.Pressure Pd(start=2e5)  "Discharge pressure";
      Modelica.Units.SI.Pressure P_throat(start=0.8e5) "Throat static pressure";

      // --- Enthalpies ---
      Modelica.Units.SI.SpecificEnthalpy hp "Motive specific enthalpy";
      Modelica.Units.SI.SpecificEnthalpy hs "Suction specific enthalpy";
      Modelica.Units.SI.SpecificEnthalpy hd "Discharge specific enthalpy";

      // --- Densities ---
      Modelica.Units.SI.Density rhop "Motive fluid density";
      Modelica.Units.SI.Density rhos "Suction fluid density";
      Modelica.Units.SI.Density rhom "Mixed fluid density at throat";

      // --- Mass flow rates (positive = into component) ---
      Modelica.Units.SI.MassFlowRate m_motive   "Motive mass flow rate";
      Modelica.Units.SI.MassFlowRate m_suction  "Suction mass flow rate";
      Modelica.Units.SI.MassFlowRate m_discharge "Discharge mass flow rate";

      // --- Velocities ---
      Modelica.Units.SI.Velocity v_nozzle   "Motive jet velocity at nozzle exit";
      Modelica.Units.SI.Velocity v_suction  "Suction flow velocity at throat entry";
      Modelica.Units.SI.Velocity v_throat   "Mixed flow velocity in throat";
      Modelica.Units.SI.Velocity v_diffuser "Mixed flow velocity at diffuser inlet";

      // --- Dimensionless performance ratios ---
      Real M(start=0.5)  "Flow ratio  Qs/Qp  (suction / motive volumetric flow)";
      Real N(start=0.3)  "Pressure ratio  (Pd-Ps)/(Pp-Pd)";
      Real C             "Density ratio  rhos/rhop";

      // --- Sub-component pressure drops ---
      Modelica.Units.SI.PressureDifference dP_nozzle   "Nozzle pressure drop";
      Modelica.Units.SI.PressureDifference dP_mixing   "Mixing chamber loss";
      Modelica.Units.SI.PressureDifference dP_diffuser "Diffuser pressure recovery";

      // ── System object (gravity, p_ambient, T_ambient) ────────────────────────
      outer Modelica.Fluid.System system;

    protected
      Medium.ThermodynamicState state_p  "Motive fluid thermodynamic state";
      Medium.ThermodynamicState state_s  "Suction fluid thermodynamic state";
      Medium.ThermodynamicState state_d  "Discharge fluid thermodynamic state";

    equation
      // ═══════════════════════════════════════════════════════════════════════
      // 1. PORT CONNECTIONS – pressures and sign conventions
      // ═══════════════════════════════════════════════════════════════════════
      Pp = port_motive.p;
      Ps = port_suction.p;
      Pd = port_discharge.p;

      // Inflow positive for motive and suction; outflow positive for discharge
      m_motive   =  port_motive.m_flow;
      m_suction  =  port_suction.m_flow;
      m_discharge= -port_discharge.m_flow;

      // ═══════════════════════════════════════════════════════════════════════
      // 2. THERMODYNAMIC STATES  (using inStream for upwind enthalpies)
      // ═══════════════════════════════════════════════════════════════════════
      hp = inStream(port_motive.h_outflow);
      hs = inStream(port_suction.h_outflow);

      state_p = Medium.setState_phX(Pp, hp, inStream(port_motive.Xi_outflow));
      state_s = Medium.setState_phX(Ps, hs, inStream(port_suction.Xi_outflow));

      rhop = Medium.density(state_p);
      rhos = Medium.density(state_s);

      // ═══════════════════════════════════════════════════════════════════════
      // 3. MASS BALANCE
      // ═══════════════════════════════════════════════════════════════════════
      m_discharge = m_motive + m_suction;          // continuity
      port_motive.m_flow + port_suction.m_flow + port_discharge.m_flow = 0;

      // ═══════════════════════════════════════════════════════════════════════
      // 4. NOZZLE  – converts motive pressure head → jet velocity
      //    Bernoulli + discharge coefficient
      //    v_nozzle = Cd * sqrt(2*(Pp - P_throat)/rhop)
      // ═══════════════════════════════════════════════════════════════════════
      dP_nozzle = Pp - P_throat;
      v_nozzle  = Cd_nozzle * sqrt(max(2 * dP_nozzle / rhop, 0));
      m_motive  = rhop * A_nozzle * v_nozzle;      // motive flow from nozzle orifice

      // ═══════════════════════════════════════════════════════════════════════
      // 5. SUCTION INLET – low-pressure side drawn in by throat vacuum
      //    Orifice equation with suction loss coefficient Ks
      // ═══════════════════════════════════════════════════════════════════════
      m_suction = rhos * (A_throat - A_nozzle) *
                  sqrt(max(2 * (Ps - P_throat) / (rhos * (1 + Ks)), 1e-6));

      // ═══════════════════════════════════════════════════════════════════════
      // 6. MIXING CHAMBER  – momentum balance in throat
      //    (rhop*Ap*vp^2 + rhos*As*vs^2) + A_throat*(Ps - Pd_throat) = (rhom*Am*vm^2)
      //    Simplified via dimensionless ratios (ESDU 85032 Cunningham formulation)
      // ═══════════════════════════════════════════════════════════════════════
      C = rhos / rhop;
      M = (m_suction / rhos) / (m_motive  / rhop);   // volumetric flow ratio

      rhom    = (m_motive + m_suction) / (m_motive/rhop + m_suction/rhos);
      v_throat   = m_discharge / (rhom * A_throat);
      v_suction  = m_suction   / (rhos * (A_throat - A_nozzle));
      v_diffuser = v_throat;                           // constant-area mixing assumed

      // Momentum equation → throat pressure
      // P_throat + rhom*v_throat^2 = Pp_eff + losses
      dP_mixing = Km * 0.5 * rhom * v_throat^2;
      P_throat  = Ps - Ks * 0.5 * rhos * v_suction^2; // throat is depressed below Ps

      // ═══════════════════════════════════════════════════════════════════════
      // 7. DIFFUSER  – pressure recovery (kinetic energy → static pressure)
      //    Kd is the diffuser loss fraction
      // ═══════════════════════════════════════════════════════════════════════
      dP_diffuser = (1 - Kd) * 0.5 * rhom *
                    (v_diffuser^2 - (m_discharge/(rhom*A_diff_out))^2);
      Pd = P_throat + dP_diffuser - dP_mixing;

      // ═══════════════════════════════════════════════════════════════════════
      // 8. ESDU PERFORMANCE CHARACTERISTIC (cross-check / alternative closure)
      //    N = (Pd - Ps) / (Pp - Pd)
      // ═══════════════════════════════════════════════════════════════════════
      N = (Pd - Ps) / max(Pp - Pd, 1e-3);

      // ═══════════════════════════════════════════════════════════════════════
      // 9. ENERGY BALANCE  – adiabatic mixing, no heat transfer
      // ═══════════════════════════════════════════════════════════════════════
      hd = (m_motive * hp + m_suction * hs) / m_discharge;
      state_d = Medium.setState_phX(Pd, hd, inStream(port_motive.Xi_outflow));

      // Reverse-flow enthalpy assignments (required by Modelica stream semantics)
      port_discharge.h_outflow = hd;
      port_motive.h_outflow    = inStream(port_discharge.h_outflow);
      port_suction.h_outflow   = inStream(port_discharge.h_outflow);

      // Species balance (single-component medium → trivial)
      port_motive.Xi_outflow   = inStream(port_discharge.Xi_outflow);
      port_suction.Xi_outflow  = inStream(port_discharge.Xi_outflow);
      port_discharge.Xi_outflow= inStream(port_motive.Xi_outflow);

          // Motive pipe (left)
          // Nozzle cone
          // Suction pipe (bottom)
          // Mixing chamber (throat)
          // Diffuser cone
          // Discharge pipe (right)
          // Labels
      annotation (
        Icon(graphics={
          Rectangle(extent={{-100,8},{-40,-8}},  fillColor={0,120,255}, fillPattern=FillPattern.Solid),
          Polygon(points={{-40,8},{-20,4},{-20,-4},{-40,-8}},
                  fillColor={0,80,200}, fillPattern=FillPattern.Solid),
          Rectangle(extent={{-6,-40},{6,-100}}, fillColor={0,180,120}, fillPattern=FillPattern.Solid),
          Rectangle(extent={{-20,12},{30,-12}}, fillColor={30,30,180}, fillPattern=FillPattern.Solid),
          Polygon(points={{30,12},{90,20},{90,-20},{30,-12}},
                  fillColor={0,60,160}, fillPattern=FillPattern.Solid),
          Rectangle(extent={{90,20},{100,-20}}, fillColor={0,120,255}, fillPattern=FillPattern.Solid),
          Text(extent={{-150,60},{150,40}},  textString="%name"),
          Text(extent={{-100,30},{-40,20}},  textString="Motive",  fontSize=8),
          Text(extent={{-20,-50},{20,-40}},  textString="Suction", fontSize=8),
          Text(extent={{60,35},{100,25}},    textString="Discharge",fontSize=8)}),
        Documentation(info="<html>
<h4>Jet Pump (Ejector) – Physical Model</h4>
<p>Models the four physical zones of a liquid-liquid jet pump:</p>
<ol>
  <li><b>Motive nozzle</b>: converts pressure → velocity via Bernoulli + Cd.</li>
  <li><b>Suction inlet</b>: secondary flow drawn by throat vacuum, with loss Ks.</li>
  <li><b>Mixing chamber</b>: momentum exchange between motive jet and suction stream, loss Km.</li>
  <li><b>Diffuser</b>: kinetic energy recovered as pressure, loss Kd.</li>
</ol>
<p>Performance is cross-checked against the ESDU 85032 (Cunningham) dimensionless
characteristic N = f(M, C, R, K*).</p>
<h4>Parameters to set for your application</h4>
<ul>
  <li><code>d_nozzle</code>, <code>d_throat</code>, <code>d_diffuser</code> – geometry from your datasheet.</li>
  <li><code>Cd_nozzle</code> – typically 0.93–0.97 for a sharp-edged nozzle.</li>
  <li>Loss coefficients Kp/Ks/Km/Kd – use 0.05/0.10/0.15/0.20 for a well-designed pump at Re > 2×10⁵.</li>
</ul>
<h4>Assumptions</h4>
<ul>
  <li>Adiabatic, steady-state, incompressible (density evaluated once per state).</li>
  <li>Single-component medium (extend Xi balance for mixtures).</li>
  <li>No cavitation guard – add <code>assert(P_throat &gt; Medium.saturationPressure(T), ...)</code> if needed.</li>
</ul>
</html>"));
    end JetPump_Claude;

    model NCFL
      extends BaseClasses.Partial_SubSystem(
        replaceable package Medium = Modelica.Media.Water.StandardWater,
        redeclare replaceable BaseClasses.CS_Dummy CS,
        redeclare replaceable BaseClasses.ED_Dummy ED,
        redeclare BaseClasses.Data_NCFL data,
        port_b(redeclare package Medium = Modelica.Media.Water.StandardWater),
        port_a(redeclare package Medium = Modelica.Media.Water.StandardWater));

      BaseClasses.Data_NCFL data(Heater_Length=1.5446375/3, Thermal_Cond=35)
        annotation (Placement(transformation(extent={{78,102},{98,122}})));
      Modelica.Fluid.Pipes.StaticPipe Slant(
        redeclare package Medium = Medium,
        length=data.Slant_Pipe_L,
        diameter=data.Pipe_D,
        height_ab=data.Slant,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01)
        annotation (Placement(transformation(extent={{-10,72},{10,92}})));
      Modelica.Fluid.Pipes.StaticPipe Distance2Heaters(
        redeclare package Medium = Medium,
        length=0.6016625,
        diameter=data.Pipe_D,
        height_ab=0.6016625,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,-82})));
      Modelica.Fluid.Pipes.StaticPipe PumpPipe(
        redeclare package Medium = Medium,
        length=1.252,
        diameter=data.Pipe_D,
        height_ab=0.3,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={70,-188})));
      TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
            Medium,
        m_flow_nominal=data.Pump_Mflow,
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{46,-198},{26,-178}})));
      Modelica.Fluid.Pipes.StaticPipe DistanceAfterHX(
        redeclare package Medium = Medium,
        length=data.Height,
        diameter=data.Pipe_D,
        height_ab=-4,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={86,-78})));


      TRANSFORM.Fluid.Volumes.MixingVolume volume(
        redeclare package Medium = Medium,
        p_start=data.Init_P,
        T_start=data.Init_T,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume,
        nPorts_a=1,
        nPorts_b=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={86,-116})));

      NHES.Fluid.Sensors.stateSensor s1(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,-114})));
      NHES.Fluid.Sensors.stateDisplay stateDisplay
        annotation (Placement(transformation(extent={{-134,-130},{-80,-100}})));
      NHES.Fluid.Sensors.stateSensor s2(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,68})));
      NHES.Fluid.Sensors.stateSensor s3(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={86,46})));
      NHES.Fluid.Sensors.stateSensor s4(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={86,-142})));
      NHES.Fluid.Sensors.stateDisplay stateDisplay1
        annotation (Placement(transformation(extent={{-134,64},{-80,94}})));
      NHES.Fluid.Sensors.stateDisplay stateDisplay2
        annotation (Placement(transformation(extent={{0,22},{54,52}})));
      NHES.Fluid.Sensors.stateDisplay stateDisplay3
        annotation (Placement(transformation(extent={{2,-104},{56,-74}})));
      Modelica.Fluid.Pipes.StaticPipe V1_Inlet(
        redeclare package Medium = Medium,
        length=0.1905,
        diameter=data.Pipe_D,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={38,-160})));
      Modelica.Fluid.Valves.ValveIncompressible V_top(
        redeclare package Medium = Medium,
        dp_nominal=data.Init_P,
        m_flow_nominal=data.Pump_Mflow/2)
        annotation (Placement(transformation(extent={{12,-170},{-8,-150}})));
      Modelica.Fluid.Valves.ValveIncompressible V_bot(
        redeclare package Medium = Medium,
        dp_nominal=data.Init_P,
        m_flow_nominal=data.Pump_Mflow/2)
        annotation (Placement(transformation(extent={{4,-198},{-16,-178}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=stateDisplay1.T)
        annotation (Placement(transformation(extent={{-210,2},{-190,22}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=-stateDisplay.T)
        annotation (Placement(transformation(extent={{-210,-24},{-190,-4}})));
      Modelica.Blocks.Math.Add T_diff
        annotation (Placement(transformation(extent={{-152,-8},{-132,12}})));
      Modelica.Fluid.Pipes.StaticPipe JetInlet(
        redeclare package Medium = Medium,
        length=0.254,
        diameter=data.JetPump_D,
        height_ab=0.254,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-9},{10,9}},
            rotation=90,
            origin={-63,-176})));
      Modelica.Fluid.Pipes.StaticPipe DistanceAfterHeaters(
        redeclare package Medium = Medium,
        length=data.Height,
        diameter=data.Pipe_D,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,42})));
      Components.Heater heater3(
        HeaterLength=data.Heater_Length,
        HeaterRadius=data.Heater_radius,
        HeaterPower=data.Heater_Power) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-62,12})));
      Components.Heater heater2(
        HeaterLength=data.Heater_Length,
        HeaterRadius=data.Heater_radius,
        HeaterPower=data.Heater_Power) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-62,-18})));
      Components.Heater heater1(
        HeaterLength=data.Heater_Length,
        HeaterRadius=data.Heater_radius,
        HeaterPower=data.Heater_Power) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-62,-52})));
      Modelica.Fluid.Pipes.StaticPipe JetSuction(
        redeclare package Medium = Medium,
        length=0.36195,
        diameter=data.Pipe_D,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-34,-160})));
      Modelica.Fluid.Pipes.StaticPipe ValveOutlet(
        redeclare package Medium = Medium,
        length=0.4572,
        diameter=data.Pipe_D,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-34,-188})));
      Modelica.Fluid.Pipes.StaticPipe JetPump(
        redeclare package Medium = Medium,
        length=data.JetPump_L,
        diameter=data.JetPump_D,
        height_ab=data.JetPump_L,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-9},{10,9}},
            rotation=90,
            origin={-65,-144})));
      Components.HX_Isolated HX(
        HXLength=data.HX_L,
        HXRadius=data.HX_radius,
        HX_Transfer=-10E3,
        Therm_cond=data.Thermal_Cond)
                           annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={88,8})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=-stateDisplay2.T)
        annotation (Placement(transformation(extent={{-212,-48},{-192,-28}})));
      Modelica.Blocks.Sources.RealExpression realExpression3(y=stateDisplay3.T)
        annotation (Placement(transformation(extent={{-212,-74},{-192,-54}})));
      Modelica.Blocks.Math.Add T_diff1
        annotation (Placement(transformation(extent={{-154,-58},{-134,-38}})));
    equation
      connect(DistanceAfterHX.port_b, volume.port_a[1])
        annotation (Line(points={{86,-88},{86,-110}},color={0,127,255}));
      connect(Distance2Heaters.port_a, s1.port_b)
        annotation (Line(points={{-64,-92},{-64,-104}}, color={0,127,255}));
      connect(s2.port_b, Slant.port_a) annotation (Line(points={{-64,78},{-64,80},{-52,
              80},{-52,82},{-10,82}},
                          color={0,127,255}));
      connect(Slant.port_b, s3.port_a)
        annotation (Line(points={{10,82},{86,82},{86,56}},   color={0,127,255}));
      connect(volume.port_b[1], s4.port_a)
        annotation (Line(points={{86,-122},{86,-132}}, color={0,127,255}));
      connect(s1.statePort, stateDisplay.statePort) annotation (Line(points={{-64.05,
              -113.95},{-48,-113.95},{-48,-144},{-50,-144},{-50,-160},{-107,-160},{-107,
              -118.9}},                                                     color
            ={0,0,0}));
      connect(s2.statePort, stateDisplay1.statePort) annotation (Line(points={{-64.05,
              68.05},{-64.05,80},{-78,80},{-78,58},{-107,58},{-107,75.1}}, color=
              {0,0,0}));
      connect(s3.statePort, stateDisplay2.statePort) annotation (Line(points={{85.95,
              45.95},{60,45.95},{60,16},{27,16},{27,33.1}},           color={0,0,
              0}));
      connect(s4.statePort, stateDisplay3.statePort) annotation (Line(points={{85.95,
              -142.05},{29,-142.05},{29,-92.9}},         color={0,0,0}));
      connect(V1_Inlet.port_a, s4.port_b) annotation (Line(points={{48,-160},{86,-160},
              {86,-152}}, color={0,127,255}));
      connect(V1_Inlet.port_b, V_top.port_a)
        annotation (Line(points={{28,-160},{12,-160}}, color={0,127,255}));
      connect(realExpression.y, T_diff.u1) annotation (Line(points={{-189,12},{-164,
              12},{-164,8},{-154,8}},        color={0,0,127}));
      connect(realExpression1.y, T_diff.u2) annotation (Line(points={{-189,-14},{-162,
              -14},{-162,-4},{-154,-4}},    color={0,0,127}));
      connect(DistanceAfterHeaters.port_b, s2.port_a)
        annotation (Line(points={{-64,52},{-64,58}}, color={0,127,255}));
      connect(heater3.port_b, DistanceAfterHeaters.port_a) annotation (Line(
            points={{-63,22},{-63,26},{-64,26},{-64,32}}, color={0,127,255}));
      connect(heater2.port_b, heater3.port_a)
        annotation (Line(points={{-63,-8},{-63,2}},  color={0,127,255}));
      connect(Distance2Heaters.port_b, heater1.port_a) annotation (Line(points={{-64,-72},
              {-64,-66},{-63,-66},{-63,-62}},          color={0,127,255}));
      connect(heater1.port_b, heater2.port_a)
        annotation (Line(points={{-63,-42},{-63,-28}}, color={0,127,255}));
      connect(V_top.port_b, JetSuction.port_a)
        annotation (Line(points={{-8,-160},{-24,-160}}, color={0,127,255}));
      connect(JetInlet.port_a, ValveOutlet.port_b) annotation (Line(points={{-63,-186},
              {-63,-188},{-44,-188}}, color={0,127,255}));
      connect(ValveOutlet.port_a, V_bot.port_b)
        annotation (Line(points={{-24,-188},{-16,-188}}, color={0,127,255}));
      connect(JetInlet.port_b, JetPump.port_a) annotation (Line(points={{-63,-166},{
              -63,-162},{-65,-162},{-65,-154}}, color={0,127,255}));
      connect(JetSuction.port_b, JetPump.port_a) annotation (Line(points={{-44,-160},
              {-65,-160},{-65,-154}}, color={0,127,255}));
      connect(JetPump.port_b, s1.port_a) annotation (Line(points={{-65,-134},{-65,-129},
              {-64,-129},{-64,-124}}, color={0,127,255}));
      connect(pump.port_b, V_bot.port_a)
        annotation (Line(points={{26,-188},{4,-188}}, color={0,127,255}));
      connect(pump.port_a, PumpPipe.port_b)
        annotation (Line(points={{46,-188},{60,-188}}, color={0,127,255}));
      connect(PumpPipe.port_a, s4.port_b) annotation (Line(points={{80,-188},{86,-188},
              {86,-152}}, color={0,127,255}));
      connect(s3.port_b, HX.port_a) annotation (Line(points={{86,36},{86,27},{86.2,27},
              {86.2,18}},          color={0,127,255}));
      connect(HX.port_b, DistanceAfterHX.port_a) annotation (Line(points={{86.2,-2},
              {86.2,-35},{86,-35},{86,-68}},     color={0,127,255}));
      connect(realExpression2.y, T_diff1.u1) annotation (Line(points={{-191,-38},{-166,
              -38},{-166,-42},{-156,-42}},
                                       color={0,0,127}));
      connect(realExpression3.y, T_diff1.u2) annotation (Line(points={{-191,-64},{-164,
              -64},{-164,-54},{-156,-54}},   color={0,0,127}));
      connect(port_a, HX.port_a1) annotation (Line(points={{104,-6},{96,-6},{96,-2},
              {92,-2}}, color={0,127,255}));
      connect(port_b, HX.port_b1) annotation (Line(points={{104,60},{104,24},{92,24},
              {92,18}}, color={0,127,255}));
      annotation (experiment(StartTime=0, StopTime=180, Interval=0.1), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
                -200},{280,240}})),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-220,-200},{280,240}})));
    end NCFL;
  end Components;

  package ControlSystems
    model RegularCS
      extends BaseClasses.CS_Dummy;
    end RegularCS;
  end ControlSystems;

  package BaseClasses
    extends Modelica.Icons.BasesPackage;
    model Data_NCFL
      extends NHES.Systems.EnergyStorage.SHS_Two_Tank.BaseClasses.Record_Data;

      //System Constants
      parameter Modelica.Units.SI.Length Slant = 0.3302 annotation(Dialog(tab="System", group = "Geometry"));
      parameter Modelica.Units.SI.Length Height = 7.1628 annotation(Dialog(tab="System", group = "Geometry"));
      parameter Modelica.Units.SI.Length Width = 0.6223 annotation(Dialog(tab="System", group = "Geometry"));

      //pipe dimensions
      parameter Modelica.Units.SI.Length Pipe_D = 0.0508 annotation(Dialog(tab="System", group = "Piping"));
      parameter Modelica.Units.SI.Length Slant_Pipe_L = sqrt(Width^2+Slant^2) annotation(Dialog(tab="System", group = "Piping"));

      //Jet Pump
      parameter Modelica.Units.SI.Length JetPump_D = 0.0254 annotation(Dialog(tab="Components",group="Jet Pump"));
      parameter Modelica.Units.SI.Length JetPump_L = 0.365125 annotation(Dialog(tab="Components",group="Jet Pump"));

      //Hydraulics
      parameter Modelica.Units.SI.Pressure Init_P = 101325 annotation(Dialog(tab="System", group="Hydraulics"));
      parameter Modelica.Units.SI.Temperature Init_T = 294.15 annotation(Dialog(tab="System", group="Hydraulics"));

      //Heaters
      parameter Modelica.Units.SI.Power Heater_Power = 5.5E3 annotation(Dialog(tab="Components", group="Heaters"));
      parameter Modelica.Units.SI.Length Heater_Length = 0.381 annotation(Dialog(tab="Components", group="Heaters"));
      parameter Modelica.Units.SI.Length Heater_radius = 0.0508 annotation(Dialog(tab="Components", group="Heaters"));

      //Pump
      parameter Modelica.Units.SI.MassFlowRate Pump_Mflow = 20 annotation(Dialog(tab="Components", group="Pump"));

      //HX
      parameter Modelica.Units.SI.Length HX_L = 0.4699 annotation(Dialog(tab="Components", group="Heat Exchanger"));
      parameter Modelica.Units.SI.Length HX_radius = 0.0381 annotation(Dialog(tab="Components", group="Heat Exchanger"));
      parameter Modelica.Units.SI.Power HX_Transfer = 0 annotation(Dialog(tab="Components", group="Heat Exchanger"));
      parameter Real Thermal_Cond = 0 annotation(Dialog(tab="Components", group="Heat Exchanger"));

      //Secondary Loop
      parameter Modelica.Units.SI.Temperature sec_T annotation(Dialog(tab="System", group="Secondary Loop"));
      parameter Modelica.Units.SI.MassFlowRate sec_Mflow = 0 annotation(Dialog(tab="System", group="Secondary Loop"));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Data_NCFL;

    expandable connector SignalSubBus_SensorOutput

      extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

      annotation (defaultComponentName="sensorBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_SensorOutput;

    expandable connector SignalSubBus_ActuatorInput

      extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

      annotation (defaultComponentName="actuatorBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_ActuatorInput;

    partial model Partial_ControlSystem

      extends NHES.Systems.BaseClasses.Partial_ControlSystem;

      NHES.Systems.EnergyStorage.PCM_HITB.BaseClasses.SignalSubBus_ActuatorInput
        actuatorBus annotation (Placement(transformation(extent={{10,-120},{50,
                -80}}), iconTransformation(extent={{10,-120},{50,-80}})));
      NHES.Systems.EnergyStorage.PCM_HITB.BaseClasses.SignalSubBus_SensorOutput
        sensorBus annotation (Placement(transformation(extent={{-50,-120},{-10,
                -80}}), iconTransformation(extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="CS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));

    end Partial_ControlSystem;

    partial model Partial_SubSystem_A

      import Modelica.Constants;

      extends
        NHES.Systems.PrimaryHeatSystem.SMR_Generic.BaseClasses.Partial_SubSystem;
      extends
        NHES.Systems.PrimaryHeatSystem.SMR_Generic.BaseClasses.Record_SubSystem_A;

      Modelica.Fluid.Interfaces.FluidPort_a port_a
        annotation (Placement(transformation(extent={{94,-16},{114,4}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b
        annotation (Placement(transformation(extent={{94,50},{114,70}})));
      annotation (
        defaultComponentName="PHS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                140}})));

    end Partial_SubSystem_A;

    partial model Partial_SubSystem
      import NHES;
    replaceable package Medium = Modelica.Media.Water.StandardWater                             annotation (
         choicesAllMatching=true);

     replaceable Partial_ControlSystem CS annotation (choicesAllMatching=true,
          Placement(transformation(extent={{-18,122},{-2,138}})));
      replaceable Partial_EventDriver ED annotation (choicesAllMatching=true,
          Placement(transformation(extent={{2,122},{18,138}})));
      replaceable Data_NCFL data
        annotation (Placement(transformation(extent={{42,122},{58,138}})));

      SignalSubBus_ActuatorInput actuatorBus
        annotation (Placement(transformation(extent={{10,80},{50,120}}),
            iconTransformation(extent={{10,80},{50,120}})));
      SignalSubBus_SensorOutput sensorBus
         annotation (Placement(transformation(extent={{-50,80},{-10,120}}),
            iconTransformation(extent={{-50,80},{-10,120}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a
        annotation (Placement(transformation(extent={{94,-16},{114,4}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b
        annotation (Placement(transformation(extent={{94,50},{114,70}})));
    equation
      connect(sensorBus, ED.sensorBus) annotation (Line(
          points={{-30,100},{-16,100},{7.6,100},{7.6,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus, CS.sensorBus) annotation (Line(
          points={{-30,100},{-12.4,100},{-12.4,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, CS.actuatorBus) annotation (Line(
          points={{30,100},{12,100},{-7.6,100},{-7.6,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, ED.actuatorBus) annotation (Line(
          points={{30,100},{20,100},{12.4,100},{12.4,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(sensorBus, ED.sensorBus) annotation (Line(
          points={{-30,100},{-16,100},{7.6,100},{7.6,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus, CS.sensorBus) annotation (Line(
          points={{-30,100},{-12.4,100},{-12.4,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, CS.actuatorBus) annotation (Line(
          points={{30,100},{12,100},{-7.6,100},{-7.6,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, ED.actuatorBus) annotation (Line(
          points={{30,100},{20,100},{12.4,100},{12.4,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      annotation (
        defaultComponentName="PHS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                140}})));
    end Partial_SubSystem;

    partial record Record_SubSystem

      annotation (defaultComponentName="subsystem",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_SubSystem;

    model ED_Dummy

      extends
        NHES.Systems.PrimaryHeatSystem.SMR_Generic.BaseClasses.Partial_EventDriver;

      extends NHES.Icons.DummyIcon;

    equation

    annotation(defaultComponentName="PHS_CS");
    end ED_Dummy;

    partial model CS_Dummy
      extends BaseClasses.Partial_ControlSystem;
      extends NHES.Icons.DummyIcon;
      Modelica.Blocks.Sources.Constant const(k=1)
        annotation (Placement(transformation(extent={{-62,42},{-52,52}})));
    equation
      connect(actuatorBus.TopValve, const.y) annotation (Line(
          points={{30,-100},{30,47},{-51.5,47}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.BotValve, const.y) annotation (Line(
          points={{30,-100},{30,47},{-51.5,47}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
    end CS_Dummy;

    partial model Partial_EventDriver

      extends NHES.Systems.BaseClasses.Partial_EventDriver;

      NHES.Systems.PrimaryHeatSystem.SMR_Generic.BaseClasses.SignalSubBus_ActuatorInput
        actuatorBus annotation (Placement(transformation(extent={{10,-120},{50,
                -80}}), iconTransformation(extent={{10,-120},{50,-80}})));
      NHES.Systems.PrimaryHeatSystem.SMR_Generic.BaseClasses.SignalSubBus_SensorOutput
        sensorBus annotation (Placement(transformation(extent={{-50,-120},{-10,
                -80}}), iconTransformation(extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="ED",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})));

    end Partial_EventDriver;
  end BaseClasses;
  annotation (uses(TRANSFORM(version="1.0"), Modelica(version="4.0.0"),
      NHES(version="2")));
end INL_DT;
