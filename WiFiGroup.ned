package inet.examples.wificlustersmusicfestivals;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.contract.IIntegratedVisualizer;
import inet.applications.httptools.configurator.HttpController;
import inet.node.inet.Router;
import inet.node.wireless.AccessPoint;
import inet.node.inet.WirelessHost;
import inet.node.inet.StandardHost;
import inet.node.inet.AdhocHost;
import inet.node.dymo.DymoRouter;

network WiFiGroup
{
    parameters:
        int numHost;
	types:
		channel ethernetline extends ned.DatarateChannel
		{
			delay = 0.1us;
			datarate = 100Mbps;
		}
	submodules:
	    visualizer: <default("IntegratedCanvasVisualizer")> like IIntegratedVisualizer if hasVisualizer() {
            parameters:
                @display("p=100,400;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=100,100;is=s");
        }
        radioMediumA: Ieee80211ScalarRadioMedium {
            parameters:
                @display("p=100,200;is=s");
        }
        radioMediumB: Ieee80211ScalarRadioMedium {
            parameters:
                @display("p=100,250;is=s");
        }
        host[numHost]: DymoRouter {
            parameters:
                @display("p=250,200");
        }
		httpController: HttpController {
            parameters:
                @display("is=s;p=100,300;i=block/cogwheel");
        }
        srv: StandardHost {
            parameters:
                @display("p=250,150;i=device/server");
        }
        router_c: DymoRouter {
            parameters:
                @display("p=400,200");
        }
        router_s: DymoRouter {
            parameters:
                @display("p=750,200");
        }
	connections:
	    router_s.ethg++ <--> ethernetline <--> srv.ethg++;
}

