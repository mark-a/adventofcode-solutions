var x = 0;
var y = 0;
var moves = document.documentElement.innerText.split(", ");
//var moves = ["R2", "L3"];
//var moves = ["R2","R2","R2"];
//var moves = ["R5", "L5", "R5", "R3"];
//var moves = ["R8", "R4", "R4", "R8"];

var directions = {
    N : {x: 0 , y: -1, L: "W",R: "E"},
    S : {x: 0 , y: 1, L: "E",R: "W"},
    W : {x: -1 , y: 0, L: "S",R: "N"},
    E: { x: 1, y: 0, L: "N",R: "S"}
};

var locations = { "0:0": 1};
var currentDirection = 'N';
var visited = false;

for(var m=0;m<moves.length;m++){
    var direction = moves[m][0];
    currentDirection = directions[currentDirection][direction];
    var steps = parseInt(moves[m].substring(1,moves[m].length),10);
    for(var s =0; s <steps;s++){
        x += parseInt(directions[currentDirection].x,10);
        y += parseInt(directions[currentDirection].y,10);
        if(!locations[x+":"+y]){
            locations[x+":"+y] = 1;
        }else{
            locations[x+":"+y] += 1;
            if(!visited){
                visited = true;
                console.log("first double visit at: ",x,",",y);
                console.log("min dist.to visit:",Math.abs(x)+Math.abs(y));
            }
        }
    }
}

console.log("at the end at: ",x,",",y);
console.log("min dist. to end:",Math.abs(x)+Math.abs(y));