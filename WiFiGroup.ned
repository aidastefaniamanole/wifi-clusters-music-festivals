package inet.examples.wificlustersmusicfestivals;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.AdhocHost;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.contract.IIntegratedVisualizer;
import inet.examples.wireless.power.PowerNetwork;
import inet.applications.httptools.configurator.HttpController;
import inet.node.inet.StandardHost;
import inet.node.inet.Router;
import inet.node.wireless.AccessPoint;

network WiFiGroup extends PowerNetwork
{
	types:
		channel ethernetline extends ned.DatarateChannel
		{
			delay = 0.1us;
			datarate = 100Mbps;
		}
	submodules:
		httpController: HttpController {
            parameters:
                @display("is=s;p=100,200;i=block/cogwheel");
        }
        srv: StandardHost {
            parameters:
                @display("p=250,150;i=device/server");
        }
        router_c: AccessPoint {
            parameters:
                @display("p=400,200;i=abstract/router");
        }
        router_s: Router {
            parameters:
                @display("p=750,200;i=abstract/router");
        }
	connections:
	    router_s.ethg++ <--> ethernetline <--> srv.ethg++;
	    router_c.ethg++ <--> ethernetline <--> router_s.ethg++;
//	    for i=0..numHost-1 {
//            host[i].ethg++ <--> ethernetline <--> router_c.ethg++;
//        }
}

