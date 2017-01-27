<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
     
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

<style> 
h1,h2, title,p,a, select, input, form, button {
    font: 100% consolas; 
    text-align: center;
   }
   
   h3{
    font: 80% consolas; 
    text-align: center;
   }
   
   .col-md-4{
   display: inline-block;
   margin: 0 auto; 
   text-align: center;
   }
   
   .row{
   display: block;
   margin: 0 auto; 
   text-align: center;
   }
   
   canvas, .container, form{
   display: block; 
   margin: 0 auto;
   }     
   
   canvas {
   border: 2px dotted grey;
   }
</style>

    
    <spring:url value="/resources/core/js/three.js" var="threeJs" />
    <script src="${threeJs}"></script>
    
     <spring:url value="/resources/core/js/OrbitControls.js" var="OrbitControlsJs" />
    <script src="${OrbitControlsJs}"></script>
    
    
   
 



<div class="jumbotron">
    <div class="container">
        <h1>${title}</h1>
    <div id = "container">

  <canvas id="glcanvas" width="800" height="600"  onload="draw()">
    Your browser doesn't appear to support the HTML5 <code>&lt;canvas&gt;</code> element.
  </canvas>
 </div> 
  
</div>

<div class="container">
    <div class="row">
        <div class="col-md-4">
            
            <h3>column # 1</h3>
            <select id="select1" size=4 onChange="draw()">
                 <option> Zero </option>
                 <option> One </option>
                 <option> Two </option>
                 <option> Three </option>
                 <option> Four </option>
                 <option> Five </option>
                 <option> Six </option>
                 <option> Seven </option>
                 <option> Eight </option>
                 <option> Nine </option>
            </select>
        </div>
        <div class="col-md-4">
            <h3>column # 2</h3>
            <select id="select2"  size=4 onChange="draw()">
                 <option> Zero </option>
                 <option> One </option>
                 <option> Two </option>
                 <option> Three </option>
                 <option> Four </option>
                 <option> Five </option>
                 <option> Six </option>
                 <option> Seven </option>
                 <option> Eight </option>
                 <option> Nine </option>
            </select>
        </div>
        <div class="col-md-4">
            <h3>column # 3</h3>
            <select id="select3" size=4 onChange="draw()">
                 <option> Zero </option>
                 <option> One </option>
                 <option> Two </option>
                 <option> Three </option>
                 <option> Four </option>
                 <option> Five </option>
                 <option> Six </option>
                 <option> Seven </option>
                 <option> Eight </option>
                 <option> Nine </option>
            </select>
            
        </div>
        <div class="col-md-4">
            <h3>column # 4</h3>
            <select id="select4"  size=4 onChange="draw()">
                 <option> Zero </option>
                 <option> One </option>
                 <option> Two </option>
                 <option> Three </option>
                 <option> Four </option>
                 <option> Five </option>
                 <option> Six </option>
                 <option> Seven </option>
                 <option> Eight </option>
                 <option> Nine </option>
            </select>
        </div>
        <div class="col-md-4">
            <h3>column # 5</h3>
            <select id="select5" size=4 onChange="draw()">
                 <option> Zero </option>
                 <option> One </option>
                 <option> Two </option>
                 <option> Three </option>
                 <option> Four </option>
                 <option> Five </option>
                 <option> Six </option>
                 <option> Seven </option>
                 <option> Eight </option>
                 <option> Nine </option>
            </select>
        </div>
    </div>
            <p>
                <a href = "" onClick="clear()"> clear</a>
                <a><input type="checkbox" id="check_animation" onChange="draw()" onClick="draw()"> animate</a>
            </p>
    
    <footer>
    
    <form  id ="amountOfCubes" method="post" modelAttribute="aquarium" >
    <input id ="amounts" name="amounts" />
    <button id="calc_button" type="submit">calculate</button><br>
	</form>	
	    <p>coordinates for water cubes ${coordinatesOfWaterCubes}</p>
        <p>&copy; Daria, 2017 </p>
    </footer>  
    </div>
</div>



 
  <script type="text/javascript">
    
    
 
  
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
       
    	
    	    	
    	var cubes =[];  
    	var isWater = false;
                          
        if("${water}"=="true"){
    	   isWater = true; 
        } 
    	
       document.getElementById("calc_button").disabled = isWater; 
       document.getElementById('amounts').disabled = isWater;
       
       if(isWater){  
    	 document.getElementById('select'+1).options[<c:out value="${selectedCubes[0]}"/>].selected=true;
    	 document.getElementById('select'+2).options[<c:out value="${selectedCubes[1]}"/>].selected=true;
         document.getElementById('select'+3).options[<c:out value="${selectedCubes[2]}"/>].selected=true;
         document.getElementById('select'+4).options[<c:out value="${selectedCubes[3]}"/>].selected=true;
         document.getElementById('select'+5).options[<c:out value="${selectedCubes[4]}"/>].selected=true;
       } 
       
        for(var i=1; i<6;i++){
               var selector = document.getElementById('select'+i);             
               var index ;
               if (selector.selectedIndex!=-1){
                   index=selector.options[selector.selectedIndex].index;
               } else{
                   index=0;
               }
               cubes.push(index);
               selector.disabled= isWater;
     	 }
    	  amountOfCubes = cubes;
    	  
    	  var sc =cubes;
          if(isWater){
        	  sc ="${selectedCubesString}".split(",")   ;
        	  amountOfCubes = sc;
          	     	
          } else{
        	  amountOfCubes = cubes;
        	  
          }
          document.getElementById('amountOfCubes').value = amountOfCubes;
          document.getElementById('amounts').value = amountOfCubes;
      
       
    
        scene = new THREE.Scene();
        scene.background = new THREE.Color(0xF4F6F7);
        scene.fog = new THREE.FogExp2( 0xcccccc, 0.002 );
        camera = new THREE.PerspectiveCamera( 75, window.innerWidth/window.innerHeight, 0.1, 1000 );
       
        
        
        // var light = new THREE.AmbientLight(0xffffff,0.5);
       // scene.add(light);
       // var light1 = new THREE.PointLight(0xffffff,0.5);
       // scene.add(light1);
        var cubesContainer = new THREE.Object3D();
        scene.add( cubesContainer );
        
        var geometry = new THREE.BoxGeometry( 1.3, 1.3, 1.3 );
        var material = new THREE.MeshBasicMaterial( { color: 0x566573, wireframe: true, shading: THREE.FlatShading, 
        vertexColors: THREE.VertexColors } );
        
        var material2 = new THREE.MeshBasicMaterial( { color: 0xA9CCE3  ,  shading: THREE.FlatShading, 
            vertexColors: THREE.VertexColors, transparent: true,  opacity: 0.95 } );
        
       var deltaX=sc.length/2-1;
       if(sc.lenght % 2!=0){
    	 //  deltaX+=0,5;
       }
        
        for(var i=0; i<sc.length;i++){
            for(var j=0; j<sc[i];j++){
                
            	var cube = new THREE.Mesh(geometry, material);
                                       
                cube.position.x=(i-deltaX)*1.3;
                cube.position.y=j*1.3-1.5;

                cube.updateMatrix();
                cube.matrixAutoUpdate = false;
                
                cubesContainer.add(cube);
            }
        }
                    
        // for(var i=-2; i<3;i++){
        //     for(var j=0; j<cubes[i+2];j++){
                
        //     	var cube = new THREE.Mesh(geometry, material);
                                       
        //         cube.position.x=i*1.3;
        //         cube.position.y=j*1.3-1.5;
                
                
        
        //         cubesContainer.add(cube);
        //     }
        // }
       
		if(coordinates!=""){
		 	var coord = coordinates.split(";");
			for(var i=0; i<coord.length; i++){
				var cube = new THREE.Mesh( geometry, material2 );
				
				
				
				geometry.faces[ 8 ].color.setHex( 0x2E4053);
				geometry.faces[ 9 ].color.setHex( 0x2E4053);
				geometry.faces[ 11 ].color.setHex( 0x2E4053);
				geometry.faces[ 10 ].color.setHex( 0x2E4053);
				geometry.__dirtyColors = true;
              
 		        //   cube.position.x=(coord[i]-2)*1.3;
 		        cube.position.x=(coord[i]-deltaX)*1.3;
                i++;
                
                // cube.position.y=(coord[i]-1)*1.3-1.5;
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
    
   
    
   
        
</script>

<!-- 
<spring:url value="/resources/core/js/OrbitControls.js" var="orbitJs" />
<script src="${orbitJs}"></script>
-->
    
    
</div>
</body>
</html>