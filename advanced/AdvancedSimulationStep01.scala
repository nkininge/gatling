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

package dockerregistry.advanced

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

class AdvancedSimulationStep01 extends Simulation {

  // Let's split this big scenario into composable business processes, like one would do with PageObject pattern with Selenium

  // object are native Scala singletons
  object Search {

    val search = exec(
      http("Home") // let's give proper names, they are displayed in the reports, and used as keys
        .get("/")
    ).pause(1) // let's set the pauses to 1 sec for demo purpose
      .exec(
        http("Search")
          .get("/namespaces")
      )
      .pause(1)
      .exec(
        http("Select")
          .get("/namespaces/17")
      )
      .pause(1)
  }

  object Browse {

    val browse = exec(
      http("Home")
        .get("/")
    ).pause(2)
      .exec(
        http("Page 1")
          .get("/repositories/386")
      )
      .pause(670 milliseconds)
      .exec(
        http("Page 2")
          .get("/repositories/388")
      )
      .pause(629 milliseconds)
      .exec(
        http("Page 3")
          .get("/repositories/484")
      )
      .pause(734 milliseconds)
      .exec(
        http("Page 4")
          .get("/v2/docker-sandbox.infra.cloudera.com/20200210_212512_0/manifests/latest")
      )
      .pause(5)
  }

  object Edit {

    val edit = exec(
      http("Form")
        .get("/repositories")
    ).pause(1)
      .exec(
        http("Post")
          .post("/repositories")
          .formParam("name", "Beautiful Computer")
      )
  }

  val httpProtocol = http
    .baseUrl("https://ui-docker-sandbox.infra.cloudera.com")
    .acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
    .doNotTrackHeader("1")
    .acceptLanguageHeader("en-US,en;q=0.5")
    .acceptEncodingHeader("gzip, deflate")
    .userAgentHeader("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:16.0) Gecko/20100101 Firefox/16.0")

  // Now, we can write the scenario as a composition
  val scn = scenario("Scenario Name").exec(Search.search, Browse.browse)

  setUp(scn.inject(atOnceUsers(1)).protocols(httpProtocol))
}
