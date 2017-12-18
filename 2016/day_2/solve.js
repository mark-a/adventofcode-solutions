var x = 1;
var y = 1;
var lines = document.documentElement.innerText.split("\n");
//var lines = "ULL\nRRDDD\nLURDL\nUUUUD".split("\n");
var pad = [[1,2,3],[4,5,6],[7,8,9]];

for(var l=0;l<lines.length;l++){
    var moves = lines[l].split("");
    if (moves.length > 0) {
        for(var m=0;m<moves.length;m++){
            switch(moves[m]) {
                case 'U':
                    if (y > 0){
                        y-=1;
                    }
                    break;
                case 'D':
                    if (y < 2){
                        y+=1;
                    }
                    break;
                case 'L':
                    if (x > 0){
                        x-=1;
                    }
                    break;
                case 'R':
                    if (x < 2){
                        x+=1;
                    }
                    break;
            }
        }
        console.log("step 1 " + (l+1) + ". letter :" + pad[y][x]);
    }
}

var pad2 = [[0,0,1,0,0],[0,2,3,4,0],[5,6,7,8,9],[0,'A','B','C',0],[0,0,'D',0,0]];
x = 0;
y = 2;
for(var l=0;l<lines.length;l++){
    var moves = lines[l].split("");
    if (moves.length > 0) {
        for(var m=0;m<moves.length;m++){
            switch(moves[m]) {
                case 'U':
                    if (y > 0 && pad2[y-1][x]){
                        y-=1;
                    }
                    break;
                case 'D':
                    if (y < 4 && pad2[y+1][x]){
                        y+=1;
                    }
                    break;
                case 'L':
                    if (x > 0 && pad2[y][x-1]){
                        x-=1;
                    }
                    break;
                case 'R':
                    if (y < 4 && pad2[y][x+1]){
                        x+=1;
                    }
                    break;
            }
        }
        console.log("step 2 "+ (l+1) + ". letter"+x+" "+y+" :" + pad2[y][x]);
    }
}

