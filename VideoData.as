package {
  
  public class VideoData {
    
    public var src:String;
    public var url:String;
    public var random:Number;
    function VideoData(src, url){
      this.src = src;
      this.url = url;
      this.random = Math.random();
    }
    
  }
  
}