public class Route {
    
    
    /**********FIELDS********/
    
    private String name;
    private int value;   
    private boolean[] possibilities = {true,true,true,
                                       true,true,true,
                                       true,true,true};
    
    /**********CONSTRUTCTORS********/
    
    public Route(){
        this.name = "";
    }
    
    public Route(JSON json){
        //do some magic with json
        //name = json.name
        //points[] = json.points[]
    }
    
    
    
    /**********SETTERS AND GETTERS********/
    
    public String getName(){
        return this.name;
    }
    
    public String getPoint(int a){
        return this.Points[a];
    }
}