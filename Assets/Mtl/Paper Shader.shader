Shader "Custom/Paper Shader" {
	Properties
	{
		_MainTex ("Base (RGBA)", 2D) = "white" {}
		_PaperTex ("Paper (RGB)", 2D) = "white" {}
	}
	
	SubShader
	{
		Tags {"Queue"="Transparent" "RenderType"="Transparent"}
		Blend SrcAlpha OneMinusSrcAlpha
		AlphaTest GEqual 0.1	
		Pass
		{
		    CGPROGRAM
		    #pragma exclude_renderers ps3 xbox360 flash
		    #pragma fragmentoption ARB_precision_hint_fastest
		    #pragma vertex vert
		    #pragma fragment frag
		 		 
		    // uniforms
		    uniform sampler2D _MainTex;
		    uniform sampler2D _PaperTex; 
		    uniform float4 _MainTex_ST;  //texture name + ST is needed to get the tiling/offset
		    uniform float4 _PaperTex_ST;
		    
		    struct vertexInput
		    {
		        float4 vertex : POSITION; 
		        float4 texcoord : TEXCOORD0;
		    };
		 
		    struct fragmentInput
		    {
		        float4 pos : SV_POSITION;
		        half2 uv : TEXCOORD0;
		        half2 uv2 : TEXCOORD1;
		    };
		 
		    fragmentInput vert( vertexInput i )
		    {
		        fragmentInput o;
		        o.pos = mul( UNITY_MATRIX_MVP, i.vertex );
		 	 	o.uv = i.texcoord;
		        o.uv2 =  i.vertex.xy * _PaperTex_ST.xy * 0.25f + _PaperTex_ST.zw;	// xy is tiling and zw is offset
		        return o;
		    }
		 
		    half4 frag( fragmentInput i ) : COLOR
		    {
			    half4 main = tex2D( _MainTex, i.uv );
			    half4 colour = tex2D( _PaperTex, i.uv2 );
			    colour.rgb *= main.rgb;
			    colour.a = main.a;
		        return colour;
		    }
		 
		    ENDCG
		}
	}
	
	FallBack "Diffuse"
}
