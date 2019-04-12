/**
 * x,y,z为相机的位置
 * inclination调整太阳的倾斜
 * azimuth调整太阳的方位角
 */

function addMy3DScene( x, y, z, inclination, azimuth ,basePath ) {
	console.log("ss");
        if ( WEBGL.isWebGLAvailable() === false ) {

            document.body.appendChild( WEBGL.getWebGLErrorMessage() );

        }

        var container, stats;
        var camera, scene, renderer, light;
        var controls, water, sphere;

        init();
        animate();

        function init() {
        	console.log("ss");
            container = document.getElementById( 'WebGL-Container' );
            console.log("sswwww")
            //

            renderer = new THREE.WebGLRenderer();
            renderer.setPixelRatio( window.devicePixelRatio );
            renderer.setSize( window.innerWidth, window.innerHeight );
            container.appendChild( renderer.domElement );

            //

            scene = new THREE.Scene();

            //

            camera = new THREE.PerspectiveCamera( 55, window.innerWidth / window.innerHeight, 1, 20000 );
            camera.position.set( x, y, z );

            //

            light = new THREE.DirectionalLight( 0xffffff, 0.8 );
            scene.add( light );

            // Water

            var waterGeometry = new THREE.PlaneBufferGeometry( 10000, 10000 );

            water = new THREE.Water(
                waterGeometry,
                {
                    textureWidth: 512,
                    textureHeight: 512,
                    waterNormals: new THREE.TextureLoader().load( '../textures/waternormals.jpg', function ( texture ) {

                        texture.wrapS = texture.wrapT = THREE.RepeatWrapping;

                    } ),
                    alpha: 1.0,
                    sunDirection: light.position.clone().normalize(),
                    sunColor: 0xeeeeee,
                    waterColor: 0x001e0f,
                    distortionScale: 3.7,
                    fog: scene.fog !== undefined
                }
            );

            water.rotation.x = - Math.PI / 2;

            scene.add( water );

            // Skybox

            var sky = new THREE.Sky();
            sky.scale.setScalar( 10000 );
            scene.add( sky );

            var uniforms = sky.material.uniforms;

            uniforms.turbidity.value = 10;
            uniforms.rayleigh.value = 2;
            uniforms.luminance.value = 1;
            uniforms.mieCoefficient.value = 0.005;
            uniforms.mieDirectionalG.value = 0.8;

            var parameters = {
                distance: 400,
                inclination: inclination,
                azimuth: azimuth
            };

            var cubeCamera = new THREE.CubeCamera( 1, 20000, 256 );
            cubeCamera.renderTarget.texture.minFilter = THREE.LinearMipMapLinearFilter;

            function updateSun() {

                var theta = Math.PI * ( parameters.inclination - 0.5 );
                var phi = 2 * Math.PI * ( parameters.azimuth - 0.5 );

                light.position.x = parameters.distance * Math.cos( phi );
                light.position.y = parameters.distance * Math.sin( phi ) * Math.sin( theta );
                light.position.z = parameters.distance * Math.sin( phi ) * Math.cos( theta );

                sky.material.uniforms.sunPosition.value = light.position.copy( light.position );
                water.material.uniforms.sunDirection.value.copy( light.position ).normalize();

                cubeCamera.update( renderer, scene );

            }

            updateSun();

            //

            var geometry = new THREE.IcosahedronBufferGeometry( 20, 1 );
            var count = geometry.attributes.position.count;

            var colors = [];
            var color = new THREE.Color();

            for ( var i = 0; i < count; i += 3 ) {

                color.setHex( Math.random() * 0xffffff );

                colors.push( color.r, color.g, color.b );
                colors.push( color.r, color.g, color.b );
                colors.push( color.r, color.g, color.b );

            }

            geometry.addAttribute( 'color', new THREE.Float32BufferAttribute( colors, 3 ) );

            var material = new THREE.MeshStandardMaterial( {
                vertexColors: THREE.VertexColors,
                roughness: 0.0,
                flatShading: true,
                envMap: cubeCamera.renderTarget.texture,
                side: THREE.DoubleSide
            } );

            sphere = new THREE.Mesh( geometry, material );
            scene.add( sphere );

            //

            controls = new THREE.OrbitControls( camera, renderer.domElement );
            controls.target.set( 40, 40, -80 );
            controls.enableZoom = false;
            controls.maxPolarAngle = Math.PI /2;
            controls.minPolarAngle = Math.PI /3;
            camera.lookAt( controls.target );

            window.addEventListener( 'resize', onWindowResize, false );

        }

        function onWindowResize() {

            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();

            renderer.setSize( window.innerWidth, window.innerHeight );

        }

        function animate() {
            requestAnimationFrame( animate );
            render();
        }

        function render() {

            var time = performance.now() * 0.001;

            sphere.position.y = Math.sin( time ) * 20 + 5;
            sphere.rotation.x = time * 0.5;
            sphere.rotation.z = time * 0.51;

            water.material.uniforms.time.value += 1.0 / 60.0;

            renderer.render( scene, camera );

        }

}