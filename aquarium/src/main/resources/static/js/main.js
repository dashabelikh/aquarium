
function clear(){

}
// model.addAttribute("someObject", new Login("uname","pass"))
// var user_pass = ${someObject.pass};

var amountOfCubes = [];
var coordinates = "${coordinatesOfWaterCubes}";

var camera, controls, scene, renderer;
var container, stats;
var cross;

draw();

function draw() {


    amountOfCubes =[];
    var isWater = false;

    if("${water}"=="true"){
        isWater = true;
    }

    document.getElementById("calc_button").disabled = isWater;
    document.getElementById('amounts').disabled = isWater;

    var sc;
    if(isWater){

        sc ="${selectedCubesString}".split(",")   ;

        for(var i=0; i<5;i++){
            var value = sc[i];
            if (typeof variable === 'undefined' || value === null){
                value = 0;
            }
            if(value>9){
                value=9;
            }
            document.getElementById('select'+(i+1)).options[value].selected=true;
        }
    }

    for(var i=1; i<6;i++){
        var selector = document.getElementById('select'+i);
        var index ;
        if (selector.selectedIndex!=-1){
            index=selector.options[selector.selectedIndex].index;
        } else{
            index=0;
        }
        amountOfCubes.push(index);
        selector.disabled= isWater;
    }

    if(isWater){
        amountOfCubes = sc;
    }
    document.getElementById('amountOfCubes').value = amountOfCubes;
    document.getElementById('amounts').value = amountOfCubes;

    scene = new THREE.Scene();
    scene.background = new THREE.Color(0xF4F6F7);
    scene.fog = new THREE.FogExp2( 0xcccccc, 0.002 );
    camera = new THREE.PerspectiveCamera( 75, window.innerWidth/window.innerHeight, 0.1, 1000 );

    // lights

    light = new THREE.DirectionalLight( 0xffffff );
    light.position.set( 1, 1, 1 );
    scene.add( light );

    light = new THREE.DirectionalLight( 0x002288 );
    light.position.set( -1, -1, -1 );
    scene.add( light );

    light = new THREE.AmbientLight( 0x222222 );
    scene.add( light );

    var cubesContainer = new THREE.Object3D();
    scene.add( cubesContainer );

    var geometry = new THREE.BoxGeometry( 1.3, 1.3, 1.3 );
    var geometryWater = new THREE.BoxGeometry( 1.3, 1.3, 1.3 );
    var material = new THREE.MeshBasicMaterial( { color: 0x566573, wireframe: true, shading: THREE.FlatShading,
        vertexColors: THREE.VertexColors } );

    var material2 = new THREE.MeshBasicMaterial( { color: 0xA9CCE3  ,  shading: THREE.FlatShading,
        vertexColors: THREE.VertexColors } );

    var deltaX=amountOfCubes.length/2-1;
    if(amountOfCubes.length/2 % 2>0){
        deltaX+=0.5;
    }

    for(var i=0; i<amountOfCubes.length;i++){
        for(var j=0; j<amountOfCubes[i];j++){

            var cube = new THREE.Mesh(geometry, material);

            cube.position.x=(i-deltaX)*1.3;
            cube.position.y=j*1.3-1.5;

            cube.updateMatrix();
            cube.matrixAutoUpdate = false;

            cubesContainer.add(cube);
        }
    }

    if(coordinates!=""){
        var coord = coordinates.split(";");
        for(var i=0; i<coord.length; i++){
            var cube = new THREE.Mesh( geometryWater, material2 );

            geometryWater.faces[ 8 ].color.setHex( 0x2E4053);
            geometryWater.faces[ 9 ].color.setHex( 0x2E4053);
            geometryWater.faces[ 11 ].color.setHex( 0x2E4053);
            geometryWater.faces[ 10 ].color.setHex( 0x2E4053);
            geometryWater.__dirtyColors = true;

            cube.position.x=(coord[i]-deltaX)*1.3;
            i++;

            cube.position.y=(coord[i]-1)*1.3-1.5;

            cube.updateMatrix();
            cube.matrixAutoUpdate = false;

            // cube.geometry.faces[ 5 ].color.setHex( 0x000000 );
            cubesContainer.add(cube);


        }
    }

    renderer = new THREE.WebGLRenderer({canvas:document.getElementById('glcanvas'), antialias: true, alpha: true});

    camera.position.z = 8;
    //  camera.position.x = amountOfCubes.length/2;
    //  camera.position.y = 2;
    window.addEventListener( 'resize', onWindowResize, false );

    container = document.getElementById( 'container' );
    container.appendChild( renderer.domElement );

    controls = new THREE.OrbitControls( camera ,container);
    controls.addEventListener( 'change', render );

    render();

    animate();
};


function onWindowResize() {

    camera.aspect = 800 / 600;
    camera.updateProjectionMatrix();

    renderer.setSize( 800, 600 );

    render();

}

function animate() {
    requestAnimationFrame( animate );
    controls.update();
}

function render() {
    renderer.render( scene, camera );
}