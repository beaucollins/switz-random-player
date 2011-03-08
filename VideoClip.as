package {
  
  import flash.display.MovieClip;
  import fl.video.FLVPlayback;
  import fl.video.VideoEvent;
  import fl.video.VideoState;
  import flash.events.MouseEvent;
  
  public class VideoClip extends MovieClip {
  
    private var video_player:FLVPlayback;
    private var video_data:VideoData;
    private var provider:IVideoProvider;
    private var play_count:int;
    function VideoClip(provider:IVideoProvider){
      play_count = 0;
      this.provider = provider;
      video_player = new FLVPlayback();
      video_player.volume = 0;
      video_player.addEventListener(VideoEvent.STATE_CHANGE, playbackDoneOrError);
      addChild(video_player);
      video_player.width = 140;
      video_player.height = 105;
      
      drawBackground();
      buttonMode = true;
      useHandCursor = true;
      
      addEventListener(MouseEvent.CLICK, videoClicked);
    }
    
    private function videoClicked(e:MouseEvent){
      provider.videoClicked(video_data);
    }
    
    public function startNewVideo(){
      video_data = provider.getVideoData()
      if(video_data != null){
        playVideoSource(video_data.src);
      }
      
    }
    
    public function playVideoSource(src:String){
      play_count ++;
      trace("Play count:: " + play_count);
      video_player.source = src;
      video_player.seek(0);
      video_player.play();
    }
    
    public function swapVideo(){
      video_data = provider.swapVideo(video_data);
      if(video_data != null){
        playVideoSource(video_data.src);        
      }
    }
    
    private function playbackDoneOrError(e:VideoEvent){
      if(e.state == VideoState.CONNECTION_ERROR || e.state == VideoState.STOPPED){
        //put the video back and ask for a new one
        swapVideo();
      }else{
        trace("State changed: " + e.state);
      }
    }
    
    private function drawBackground(){
      var w:Number = video_player.width;
      var h:Number = video_player.height;
      graphics.beginFill(0x000000);
      graphics.moveTo(0,0);
      graphics.lineTo(w,0);
      graphics.lineTo(w,h);
      graphics.lineTo(0,h);
      graphics.lineTo(0,0);
      graphics.endFill();
      
    }
    
  }
  
}