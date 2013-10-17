package com.michaelt.toggleserver.resources

import javax.ws.rs.GET
import javax.ws.rs.Path
import javax.ws.rs.Produces
import javax.ws.rs.core.MediaType
import javax.ws.rs.QueryParam
import java.io.File
import java.util.Locale

@Path("/toggle")
@Produces(Array(MediaType.TEXT_PLAIN))
class ToggleHandler {

  val togglePath = new File("/tmp/toggles")
  val chars = "0123456789abcdefghijzlmnopqrstuvwxyz".toSet
  
  @GET
  def toggle(@QueryParam("type") toggleType : String) = {
    togglePath.mkdir
    
    getFilename(toggleType).map { name =>
      val toggleFile = new File(togglePath, name)
      if (toggleFile.exists) "already toggled"
      else if (toggleFile.createNewFile) "toggled!"
      else "toggle failed"
    }.getOrElse(toggleType + " invalid")
  }
  
  def getFilename(toggleType : String) = {
    val fileName = toggleType.trim.toLowerCase(Locale.UK)
    
    if (!fileName.forall(chars.contains)) {
      None
    } else {    
      Some(fileName)
    }
  }
  
}

