package ;

import tink.testrunner.*;
import tink.unit.*;
import tink.http.containers.*;
import tink.http.Response;
import tink.web.routing.*;
import tink.http.clients.*;
import tink.web.proxy.Remote;
import tink.url.Host;
using tink.io.Source;
using tink.CoreApi;

class RunTests {
  static function main() {
    
    // Runner.run(TestBatch.make([
      var test = new tink.web.routing.Router<cases.TestRouter<Float>>(new cases.TestRouter<Float>("collection","balance"));
      trace(test);
      var container = new tink.http.containers.LocalContainer();
      var client = new LocalContainerClient(container);
      var remote = new tink.web.proxy.Remote<cases.TestRouter<Float>>(client, new RemoteEndpoint(new Host('brave-pi.io', 8080)));
      container.run(req -> {
        trace(req);
        test.route(tink.web.routing.Context.ofRequest(req)).recover(OutgoingResponse.reportError);
      });
      remote.get().next(res -> {
        trace(res);
        res.body.all();
        
      })
      .next(c -> {
        trace('response :$c');
        Noise;
      })
      .eager();

    // ])).handle(Runner.exit);
  }
  
}

