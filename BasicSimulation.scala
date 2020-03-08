/*
 * Copyright 2011-2019 GatlingCorp (https://gatling.io)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package dockerregistry

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._
import sys.process._
class BasicSimulation extends Simulation {

  val httpProtocol = http
    .baseUrl("https://ui-docker-sandbox.infra.cloudera.com") // Here is the root for all relative URLs
    .acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8") // Here are the common headers
    .doNotTrackHeader("1")
    .acceptLanguageHeader("en-US,en;q=0.5")
    .acceptEncodingHeader("gzip, deflate")
    .userAgentHeader("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:16.0) Gecko/20100101 Firefox/16.0")

  val scn = scenario("DockerRegistry") // A scenario is a chain of requests and pauses
    .exec(
     // http("request_1")
       //.get("/")
        Process("docker pull docker-sandbox.infra.cloudera.com/20200210_212512_0:latest")
    )
    .pause(7) // Note that Gatling has recorded real time pauses
    .exec(
      http("request_2")
        .get("/namespaces")
    )
    .pause(2)
    .exec(
      http("request_3")
        .get("/repositories")
    )
    .pause(3)
    .exec(
      http("request_4")
        .get("/admin/users")
    )
    //setUp(scn.inject(rampUsers(10) over (5 seconds)).protocols(httpProtocol))
  setUp(scn.inject(atOnceUsers(1)).protocols(httpProtocol))
    //setUp(scn.inject(constantUsersPerSec(20) during (15 seconds)).protocols(httpProtocol))
}
