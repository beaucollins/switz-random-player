package {
  
  import flash.display.MovieClip;
  import flash.net.URLRequest;
  import com.adobe.serialization.json.JSON;
  import com.adobe.net.DynamicURLLoader;
  import flash.events.Event;
  import flash.external.ExternalInterface;
  import flash.display.StageScaleMode;
  import flash.display.StageAlign;
  import flash.utils.setTimeout;
  public class SwitzerlandPlayer extends MovieClip implements IVideoProvider {
    
    private var videos:Array;
    private var players:Array;
    
    public function SwitzerlandPlayer(){
      
      this.stage.scaleMode = StageScaleMode.NO_SCALE;
      this.stage.align = StageAlign.TOP_LEFT;
      
      initializePlayers();
      
      var video_json_request:URLRequest;
      video_json_request = new URLRequest;

      video_json_request.url = this.loaderInfo.parameters.url || 'http://redimastudio.com/videos.json';
      
      var request_loader = new DynamicURLLoader();
      request_loader.addEventListener(Event.COMPLETE, loadVideos);
      request_loader.load(video_json_request);
      
    }
    
    public function startPlayers(){
      trace(players.length);
      players.forEach(function(item:VideoClip, i:int, array:Array){
        trace(item);
        setTimeout(function(){
          item.startNewVideo();          
        }, i*500);
      });
    }
    
    public function getVideoData():VideoData {
      var video:VideoData = videos.shift() as VideoData;
      return video;
    }
    
    public function videoDonePlaying(video:VideoData) {
      videos.push(video);
    }
    
    public function swapVideo(video:VideoData):VideoData{
      var new_video:VideoData = getVideoData();
      videoDonePlaying(video);
      return new_video;
    }
    
    public function videoClicked(video:VideoData){
      trace("Open page:" + video.url);
      if (ExternalInterface.available) {
        ExternalInterface.call('$.slidePlayer', video.url);
      }
      
    }
    
    
    private function initializePlayers(){
      
      players = new Array();
      var p:VideoClip;
      for(var i:Number = 0; i<4;i++){
        p = new VideoClip(this);
        players.push(p);
        addChild(p);
        positionVideoWithIndex(p, i);
      }
      
    }
    
    private function positionVideoWithIndex(clip:MovieClip, index:Number){
      switch (index)
      {
        case 0 :
          clip.x = 50;
          clip.y = 90;
        break;
        case 1 :
          clip.x = 320;
          clip.y = 90;
        break;
        case 2 :
          clip.x = 50;
          clip.y = 320;
        break;
        case 3 :
          clip.x = 320;
          clip.y = 320;
        break;
      }
    }
    
    private function loadVideos(e:Event){
      
      var loader = DynamicURLLoader(e.target);
      var video_info:Array = JSON.decode(loader.data) as Array;
      videos = video_info.map(function(item:Object, index:int, array:Array){
        return new VideoData(item.src, item.url);
      }, this).sortOn('random');
      
      
      startPlayers();
    }
    
  }
  
}


