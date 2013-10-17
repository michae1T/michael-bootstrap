import sbt._
import Keys._
import sbtassembly.Plugin._
import AssemblyKeys._

object ToggleServer extends Build { 
  lazy val buildSettings = Seq(
    version := "0.1-SNAPSHOT",
    organization := "com.michaelt",
    scalaVersion := "2.10.3"
  )

  val app = (project in file("service")).
    settings(buildSettings: _*).
    settings(assemblySettings: _*).
    settings(
      jarName in assembly := "toggle-server.jar",
      mainClass in assembly := Some("com.michaelt.toggleserver.ToggleServer"),
      libraryDependencies ++= Seq(
        "org.eclipse.jetty" % "jetty-server" % "9.1.0.M0",
        "org.eclipse.jetty" % "jetty-servlet" % "9.1.0.M0",
        "com.sun.jersey" % "jersey-core" % "1.17.1",
        "com.sun.jersey" % "jersey-server" % "1.17.1",
        "com.sun.jersey" % "jersey-servlet" % "1.17.1"
      )
    )
}

