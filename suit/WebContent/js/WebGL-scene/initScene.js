function initScene( scene ) {

    var SCREEN_WIDTH = window.innerWidth;
    var SCREEN_HEIGHT = window.innerHeight;

    var container, camera, renderer;

    var controls;

    var light;

    init();
    animate();

    function init() {
        // CAMERA

        camera = new THREE.PerspectiveCamera(40, window.innerWidth / window.innerHeight, 1, 1000);
        camera.position.set(11.2, 162.4, 417.2);

        // SCENE

        scene.background = new THREE.Color(0x050505);
        scene.fog = new THREE.Fog(0x050505, 400, 1000);
        scene.castShadow = true;
        scene.receiveShadow = true;
        // LIGHTS

       // scene.add(new THREE.AxisHelper(2000));

        scene.add(new THREE.AmbientLight(0x222222));

        light = new THREE.SpotLight(0xaaaaaa, 5, 1000);
        light.position.set(200, 250, 500);
        light.angle = 0.5;
        light.penumbra = 0.5;

        light.castShadow = true;
        light.shadow.mapSize.width = 1024;
        light.shadow.mapSize.height = 1024;

        // scene.add( new THREE.CameraHelper( light.shadow.camera ) );

        scene.add(light);

        light = new THREE.SpotLight(0xaaaaaa, 5, 1000);
        light.position.set(-100, 350, 350);
        light.angle = 0.5;
        light.penumbra = 0.5;

        light.castShadow = true;
        light.shadow.mapSize.width = 1024;
        light.shadow.mapSize.height = 1024;

        // scene.add( new THREE.CameraHelper( light.shadow.camera ) );
        scene.add(light);

        //  GROUND

        var gt = new THREE.TextureLoader().load("../../textures/grasslight-big.jpg");
        var gg = new THREE.PlaneBufferGeometry(2000, 2000);
        var gm = new THREE.MeshPhongMaterial({color: 0xffffff, map: gt});

        var ground = new THREE.Mesh(gg, gm);
        ground.rotation.x = -Math.PI / 2;
        ground.material.map.repeat.set(8, 8);
        ground.material.map.wrapS = ground.material.map.wrapT = THREE.RepeatWrapping;
        ground.receiveShadow = true;
        ground.castShadow = true;

        scene.add(ground);

        // RENDERER

        renderer = new THREE.WebGLRenderer({antialias: true});
        renderer.setPixelRatio(window.devicePixelRatio);
        renderer.setSize(SCREEN_WIDTH, SCREEN_HEIGHT);
        container = $("#WebGL-Container").append(renderer.domElement);


        //
        renderer.gammaInput = true;
        renderer.gammaOutput = true;
        renderer.shadowMap.enabled = true;

        window.addEventListener('resize', onWindowResize, false);

        // CONTROLS
        controls = new THREE.OrbitControls(camera, renderer.domElement);
        controls.target.set(0, 100, 50);

        controls.update();

        // EVENT HANDLERS

        function onWindowResize() {

            SCREEN_WIDTH = window.innerWidth;
            SCREEN_HEIGHT = window.innerHeight;

            renderer.setSize(SCREEN_WIDTH, SCREEN_HEIGHT);

            camera.aspect = SCREEN_WIDTH / SCREEN_HEIGHT;
            camera.updateProjectionMatrix();

        }
    }

    function animate() {

        requestAnimationFrame( animate );
        render();

    }

    function render() {

        renderer.render( scene, camera );

    }

}