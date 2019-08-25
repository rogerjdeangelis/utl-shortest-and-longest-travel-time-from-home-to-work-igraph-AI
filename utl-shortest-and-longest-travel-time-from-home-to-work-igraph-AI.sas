Shortest and longest travel time from home to work igraph AI                                                       
                                                                                                                   
github                                                                                                             
https://tinyurl.com/y5pg5vlu                                                                                       
https://github.com/rogerjdeangelis/utl-shortest-and-longest-travel-time-from-home-to-work-igraph-AI                
                                                                                                                   
StackOverflow                                                                                                      
https://tinyurl.com/y6h9kx6b                                                                                       
https://stackoverflow.com/questions/57522871/how-to-calculate-a-maximum-bottleneck-path-with-igraph                
                                                                                                                   
SOAPBOX ON                                                                                                         
                                                                                                                   
  Some R data structures are very hard to populate with SAS data and even                                          
  more difficult to export to SAS.                                                                                 
                                                                                                                   
  Most of the code below is needed to get the result out of R.                                                     
                                                                                                                   
SOAPBOX OFF                                                                                                        
                                                                                                                   
*_                   _                                                                                             
(_)_ __  _ __  _   _| |_ ___                                                                                       
| | '_ \| '_ \| | | | __/ __|                                                                                      
| | | | | |_) | |_| | |_\__ \                                                                                      
|_|_| |_| .__/ \__,_|\__|___/                                                                                      
        |_|                                                                                                        
;                                                                                                                  
                                                                                                                   
Paths and travel taimse for mutiple routes from home to work.                                                      
                                                                                                                   
                                                                                                                   
                 10 minutes                                                                                        
 Y |             ^                                                                                                 
   |       HOME  |                                                                                                 
 1 +         A------B                                                                                              
   |          \    /                                                                                               
   |4 minutes<-\  /-> 10 minutes                                                                                   
   |            \/                                                                                                 
   |            /\                                                                                                 
   |           /  \                                                                                                
 0 +         C------D WORK                                                                                         
   |            |                                                                                                  
   |            V                                                                                                  
   |            6 mins                                                                                             
   +------------+--------                                                                                          
             0      1                                                                                              
                X                                                                                                  
                                                                                                                   
The minimum path is obvious                                                                                        
    A -- D                                                                                                         
                                                                                                                   
The maximum path                                                                                                   
    A - B - C - D                                                                                                  
                                                                                                                   
INPUTS FOR MAXIMUM TIME                                                                                            
=======================                                                                                            
                                                                                                                   
%let time=max;                                                                                                     
%let path= %str("A", "B", "C", "D");                                                                               
%let lnks=%str("A", "B", 10, "B", "C", 10, "C", "D", 6, "A", "D", 4,);                                             
                                                                                                                   
INPUTS FOR MINIMUM TIME                                                                                            
========================                                                                                           
                                                                                                                   
Rerun with Minimum travel time                                                                                     
                                                                                                                   
%let time=min;                                                                                                     
*            _               _                                                                                     
  ___  _   _| |_ _ __  _   _| |_ ___                                                                               
 / _ \| | | | __| '_ \| | | | __/ __|                                                                              
| (_) | |_| | |_| |_) | |_| | |_\__ \                                                                              
 \___/ \__,_|\__| .__/ \__,_|\__|___/                                                                              
                |_|                                                                                                
;                                                                                                                  
                                                                                                                   
                                                                                                                   
%put Travel path with longest time &=mins;                                                                         
                                                                                                                   
Travel path with longest time MINS=[1] A B C D                                                                     
                                                                                                                   
                                                                                                                   
%put Travel path with fastest time &=mins;                                                                         
                                                                                                                   
Travel path with fastest time MINS=[1] A D                                                                         
                                                                                                                   
*                                                                                                                  
 _ __  _ __ ___   ___ ___  ___ ___                                                                                 
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                                
| |_) | | | (_) | (_|  __/\__ \__ \                                                                                
| .__/|_|  \___/ \___\___||___/___/                                                                                
|_|                                                                                                                
;                                                                                                                  
                                                                                                                   
                                                                                                                   
%symdelmax path lnks / nowarn;                                                                                     
                                                                                                                   
%let time=min;                                                                                                     
%let path= %str("A", "B", "C", "D");                                                                               
%let lnks=%str("A", "B", 10, "B", "C", 10, "C", "D", 6, "A", "D", 4,);                                             
                                                                                                                   
%utl_submit_r64(resolve('                                                                                          
require(tibble);                                                                                                   
require(igraph);                                                                                                   
                                                                                                                   
nodes = data_frame("id" = c(&path));                                                                               
                                                                                                                   
links = tribble(~from, ~to, ~weight, &lnks.);                                                                      
                                                                                                                   
net = graph_from_data_frame(links, vertices = nodes, directed = T);                                                
                                                                                                                   
simple_paths <- all_simple_paths(net, "A", "D");                                                                   
                                                                                                                   
mintym<-simple_paths[which.&time.(                                                                                 
    sapply(simple_paths, function(path) {                                                                          
      min(E(net, path = path)$weight)                                                                              
    })                                                                                                             
)];                                                                                                                
tmp<-tempfile("tp");                                                                                               
sink(tmp);                                                                                                         
mintym[[1]];                                                                                                       
sink();                                                                                                            
time<-read.csv(tmp);                                                                                               
mins <- lapply(time[1,1], as.character);                                                                           
mins<-paste(mins);                                                                                                 
mins;                                                                                                              
writeClipboard(mins);                                                                                              
'),returnVar=mins);                                                                                                
                                                                                                                   
%put Travel path with longests time &=mins;                                                                        
                                                                                                                   
Travel path with longest time MINS=[1] A B C D                                                                     
                                                                                                                   
                                                                                                                   
