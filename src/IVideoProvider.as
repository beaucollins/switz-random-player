package {
  
  public interface IVideoProvider {
    
    function getVideoData():VideoData;
    function swapVideo(video:VideoData):VideoData;
    function videoDonePlaying(video:VideoData):void;
    function videoClicked(video:VideoData):void;
  }
  
}