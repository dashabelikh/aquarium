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
    
    
    
    <script type="text/javascript">
    
   
    
   
 
    // model.addAttribute("someObject", new Login("uname","pass"))
    // var user_pass = ${someObject.pass};
  
    
    var amountOfCubes = [];
   
   
    var coordinates = "${coordinatesOfWaterCubes}";
    
       
    //DrawCubes;
   // animate();   
       
    
    var DrawCubes= function () {
       
    	var camera, controls, scene, renderer;
    	
    	
    	var cubes =[];  
    	
    	var isWater = false;
                          
       if("${water}"=="true"){
    	   isWater = true; 
       } 
    	
       document.getElementById("calc_button").disabled = isWater; 
       
       
       if(coordinates!=""){
    	   
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
                    index =selector.options[selector.selectedIndex].index;
                } else{
                    index= 0;
                }
                cubes.push(index);
                selector.disabled= isWater;
            }
         
        
        amountOfCubes = cubes;
      
       // document.getElementById('amountOfCubes').value = amountOfCubes;
        document.getElementById('amountOfCubes').value = cubes;
        document.getElementById('amounts').value = cubes;
              
      
    
        scene = new THREE.Scene();
        scene.background = new THREE.Color(0xF4F6F7);
        camera = new THREE.PerspectiveCamera( 75, window.innerWidth/window.innerHeight, 0.1, 1000 );
     //   var light = new THREE.AmbientLight(0xffffff,0.5);
       // scene.add(light);
       // var light1 = new THREE.PointLight(0xffffff,0.5);
       // scene.add(light1);

        var cubesContainer = new THREE.Object3D();
        scene.add( cubesContainer );
        

        var geometry = new THREE.BoxGeometry( 1.3, 1.3, 1.3 );
        var material = new THREE.MeshBasicMaterial( { color: 0x2E4053, wireframe: true, shading: THREE.FlatShading, 
        vertexColors: THREE.FaceColors } );
        
        var material2 = new THREE.MeshBasicMaterial( { color: 0x2E4053,  shading: THREE.FlatShading, 
            vertexColors: THREE.FaceColors } );
                    
        for(var i=-2; i<3;i++){
            for(var j=0; j<cubes[i+2];j++){
                var cube = new THREE.Mesh( geometry, material );
                                       
                cube.position.x=i*1.3;
                cube.position.y=j*1.3-1.5;
        
                cubesContainer.add(cube);
            }
        }
       
		if(coordinates!=""){
		 	var coord = coordinates.split(";");
			for(var i=0; i<coord.length; i++){
				var cube = new THREE.Mesh( geometry, material2 );
              
 		        cube.position.x=(coord[i]-2)*1.3;
                i++;
                
                cube.position.y=(coord[i]-1)*1.3-1.5;
                cubesContainer.add(cube);
			}
        }
            
        renderer = new THREE.WebGLRenderer({canvas:document.getElementById('glcanvas'), antialias: true});
                        
        camera.position.z = 6;
        
     //   controls = new THREE.TrackballControls( camera );
//      controls.damping = 0.2;
       // controls.addEventListener( 'change', render );

        var render = function () {
                
                if(document.getElementById("check_animation").checked){
                    requestAnimationFrame( render );
                }
                
                //cubesContainer.rotation.x += 0.01;
                cubesContainer.rotation.y += 0.008;

                renderer.render(scene, camera);
               // controls.update();
            
            
            };
            render();       
            
            
          
    };
    
    
    
        
</script>
<!-- 
<spring:url value="/resources/core/js/OrbitControls.js" var="orbitJs" />
<script src="${orbitJs}"></script>
-->



<div class="jumbotron">
    <div class="container">
        <h1>${title}</h1>
      
    </div>
</div>


<body onload="DrawCubes()">

  <canvas id="glcanvas" width="800" height="600">
    Your browser doesn't appear to support the HTML5 <code>&lt;canvas&gt;</code> element.
  </canvas>
  
  
</body>

<div class="container">
    <div class="row">
        <div class="col-md-4">
            
            <h3>column # 1</h3>
            <select id="select1" size=4 onChange="DrawCubes()">
                 <option> Zero </option>
                 <option> One </option>
                 <option> Two </option>
                 <option> Three </option>
            </select>
        </div>
        <div class="col-md-4">
            <h3>column # 2</h3>
            <select id="select2"  size=4 onChange="DrawCubes()">
                 <option> Zero </option>
                 <option> One </option>
                 <option> Two </option>
                 <option> Three </option>
            </select>
        </div>
        <div class="col-md-4">
            <h3>column # 3</h3>
            <select id="select3" size=4 onChange="DrawCubes()">
                 <option> Zero </option>
                 <option> One </option>
                 <option> Two </option>
                 <option> Three </option>
            </select>
            
        </div>
        <div class="col-md-4">
            <h3>column # 4</h3>
            <select id="select4"  size=4 onChange="DrawCubes()">
                 <option> Zero </option>
                 <option> One </option>
                 <option> Two </option>
                 <option> Three </option>
            </select>
        </div>
        <div class="col-md-4">
            <h3>column # 5</h3>
            <select id="select5" size=4 onChange="DrawCubes()">
                 <option> Zero </option>
                 <option> One </option>
                 <option> Two </option>
                 <option> Three </option>
            </select>
        </div>
    </div>
            <p>
                
                            
  
                 
                <a ><input type="checkbox" id="check_animation" onChange="DrawCubes()" onClick="DrawCubes()"> animate</a>
            </p>
    
    <footer>
    <form  id ="amountOfCubes" method="post" modelAttribute="aquarium" action="http://localhost:8080/spring4/calc">
    <input id ="amounts" name="amounts"  readonly="readonly"/>
    <button id="calc_button" type="submit">calculate</button><br>
    
	</form>
	
        <p>coordinates for water cubes ${coordinatesOfWaterCubes}</p>
        <p>&copy; Daria, 2017 </p>
    </footer>
</div>
</body>
</html>