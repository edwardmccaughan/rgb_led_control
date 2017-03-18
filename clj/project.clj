(defproject rgb-led-control "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.8.0"]
                 [clj-serial "2.0.4-SNAPSHOT"]
                 [org.clojure/tools.logging "0.3.1"]]
  :main ^:skip-aot rgb-led-control.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
