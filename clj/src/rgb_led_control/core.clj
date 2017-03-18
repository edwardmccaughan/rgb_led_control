(ns rgb-led-control.core
  (:require [serial.core :as serial]
            [clojure.tools.logging :as log]))

(def serial-port (serial/open "/dev/ttyUSB0"))

;; colors
(def rose [19 6 9])
(def pink [59 4 21])
(def purple [38 8 60])
(def yellow [26 25 4])
(def light-green [4 36 15])

(defn set-pixel [port number]
  (serial/write port number))

(defn set-color [port rgb]
  (serial/write port (first rgb))
  (serial/write port (second rgb))
  (serial/write port (last rgb)))

(defn set-stop-byte [port]
  (serial/write port 255))

(defn set-pixel-color [port pixel rgb]
  (set-pixel port pixel)
  (set-color port rgb)
  (set-stop-byte port))

(defn -main [& args]
  ;; when the arduino serial port is first opened, it reboots the arduino,
  ;; so we need to wait a couple of seconds for it to boot up before we start sending data.
  (Thread/sleep 2000)

  (dotimes [i 24]
    (set-pixel-color serial-port i pink)
    (Thread/sleep 100)))
