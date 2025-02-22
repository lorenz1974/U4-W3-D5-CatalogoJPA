PGDMP  &                      }            u4-w3-d5-catalogoJPA    17.2    17.2 '    I           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            J           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            K           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            L           1262    17057    u4-w3-d5-catalogoJPA    DATABASE     �   CREATE DATABASE "u4-w3-d5-catalogoJPA" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Italian_Italy.1252';
 &   DROP DATABASE "u4-w3-d5-catalogoJPA";
                     postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                     pg_database_owner    false            M           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                        pg_database_owner    false    4            �            1259    17060    elementi_catalogo    TABLE       CREATE TABLE public.elementi_catalogo (
    id bigint NOT NULL,
    codice_isbn character varying(255) NOT NULL,
    titolo character varying(255) NOT NULL,
    anno_pubblicazione integer NOT NULL,
    numero_pagine integer NOT NULL,
    tipo character varying(255) NOT NULL
);
 %   DROP TABLE public.elementi_catalogo;
       public         heap r       postgres    false    4            �            1259    17059    elementi_catalogo_id_seq    SEQUENCE     �   CREATE SEQUENCE public.elementi_catalogo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.elementi_catalogo_id_seq;
       public               postgres    false    218    4            N           0    0    elementi_catalogo_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.elementi_catalogo_id_seq OWNED BY public.elementi_catalogo.id;
          public               postgres    false    217            �            1259    17068    libri    TABLE     �   CREATE TABLE public.libri (
    id bigint NOT NULL,
    autore character varying(255) NOT NULL,
    genere character varying(255) NOT NULL
);
    DROP TABLE public.libri;
       public         heap r       postgres    false    4            �            1259    17103    prestiti    TABLE     �   CREATE TABLE public.prestiti (
    id bigint NOT NULL,
    utente_id bigint NOT NULL,
    elemento_catalogo_id bigint NOT NULL,
    data_inizio_prestito date NOT NULL,
    data_restituzione_prevista date NOT NULL,
    data_restituzione_effettiva date
);
    DROP TABLE public.prestiti;
       public         heap r       postgres    false    4            �            1259    17102    prestiti_id_seq    SEQUENCE     �   CREATE SEQUENCE public.prestiti_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.prestiti_id_seq;
       public               postgres    false    224    4            O           0    0    prestiti_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.prestiti_id_seq OWNED BY public.prestiti.id;
          public               postgres    false    223            �            1259    17080    riviste    TABLE     8  CREATE TABLE public.riviste (
    id bigint NOT NULL,
    periodicita character varying(255) NOT NULL,
    CONSTRAINT riviste_periodicita_check CHECK (((periodicita)::text = ANY (ARRAY[('SETTIMANALE'::character varying)::text, ('MENSILE'::character varying)::text, ('SEMESTRALE'::character varying)::text])))
);
    DROP TABLE public.riviste;
       public         heap r       postgres    false    4            �            1259    17092    utenti    TABLE     �   CREATE TABLE public.utenti (
    id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    cognome character varying(255) NOT NULL,
    data_nascita date NOT NULL,
    numero_tessera character varying(255) NOT NULL
);
    DROP TABLE public.utenti;
       public         heap r       postgres    false    4            �            1259    17091    utenti_id_seq    SEQUENCE     �   CREATE SEQUENCE public.utenti_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.utenti_id_seq;
       public               postgres    false    222    4            P           0    0    utenti_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.utenti_id_seq OWNED BY public.utenti.id;
          public               postgres    false    221            �           2604    17119    elementi_catalogo id    DEFAULT     |   ALTER TABLE ONLY public.elementi_catalogo ALTER COLUMN id SET DEFAULT nextval('public.elementi_catalogo_id_seq'::regclass);
 C   ALTER TABLE public.elementi_catalogo ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    217    218    218            �           2604    17159    prestiti id    DEFAULT     j   ALTER TABLE ONLY public.prestiti ALTER COLUMN id SET DEFAULT nextval('public.prestiti_id_seq'::regclass);
 :   ALTER TABLE public.prestiti ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    224    223    224            �           2604    17196 	   utenti id    DEFAULT     f   ALTER TABLE ONLY public.utenti ALTER COLUMN id SET DEFAULT nextval('public.utenti_id_seq'::regclass);
 8   ALTER TABLE public.utenti ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221    222            @          0    17060    elementi_catalogo 
   TABLE DATA           m   COPY public.elementi_catalogo (id, codice_isbn, titolo, anno_pubblicazione, numero_pagine, tipo) FROM stdin;
    public               postgres    false    218   .       A          0    17068    libri 
   TABLE DATA           3   COPY public.libri (id, autore, genere) FROM stdin;
    public               postgres    false    219   [r       F          0    17103    prestiti 
   TABLE DATA           �   COPY public.prestiti (id, utente_id, elemento_catalogo_id, data_inizio_prestito, data_restituzione_prevista, data_restituzione_effettiva) FROM stdin;
    public               postgres    false    224   ��       B          0    17080    riviste 
   TABLE DATA           2   COPY public.riviste (id, periodicita) FROM stdin;
    public               postgres    false    220   ��       D          0    17092    utenti 
   TABLE DATA           Q   COPY public.utenti (id, nome, cognome, data_nascita, numero_tessera) FROM stdin;
    public               postgres    false    222   ̳       Q           0    0    elementi_catalogo_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.elementi_catalogo_id_seq', 2021, true);
          public               postgres    false    217            R           0    0    prestiti_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.prestiti_id_seq', 3001, true);
          public               postgres    false    223            S           0    0    utenti_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.utenti_id_seq', 650, true);
          public               postgres    false    221            �           2606    17143 3   elementi_catalogo elementi_catalogo_codice_isbn_key 
   CONSTRAINT     u   ALTER TABLE ONLY public.elementi_catalogo
    ADD CONSTRAINT elementi_catalogo_codice_isbn_key UNIQUE (codice_isbn);
 ]   ALTER TABLE ONLY public.elementi_catalogo DROP CONSTRAINT elementi_catalogo_codice_isbn_key;
       public                 postgres    false    218            �           2606    17121 (   elementi_catalogo elementi_catalogo_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.elementi_catalogo
    ADD CONSTRAINT elementi_catalogo_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.elementi_catalogo DROP CONSTRAINT elementi_catalogo_pkey;
       public                 postgres    false    218            �           2606    17147    libri libri_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.libri
    ADD CONSTRAINT libri_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.libri DROP CONSTRAINT libri_pkey;
       public                 postgres    false    219            �           2606    17161    prestiti prestiti_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.prestiti
    ADD CONSTRAINT prestiti_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.prestiti DROP CONSTRAINT prestiti_pkey;
       public                 postgres    false    224            �           2606    17186    riviste riviste_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.riviste
    ADD CONSTRAINT riviste_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.riviste DROP CONSTRAINT riviste_pkey;
       public                 postgres    false    220            �           2606    17212     utenti utenti_numero_tessera_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.utenti
    ADD CONSTRAINT utenti_numero_tessera_key UNIQUE (numero_tessera);
 J   ALTER TABLE ONLY public.utenti DROP CONSTRAINT utenti_numero_tessera_key;
       public                 postgres    false    222            �           2606    17198    utenti utenti_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.utenti
    ADD CONSTRAINT utenti_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.utenti DROP CONSTRAINT utenti_pkey;
       public                 postgres    false    222            �           2606    17148    libri libri_id_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.libri
    ADD CONSTRAINT libri_id_fkey FOREIGN KEY (id) REFERENCES public.elementi_catalogo(id);
 =   ALTER TABLE ONLY public.libri DROP CONSTRAINT libri_id_fkey;
       public               postgres    false    218    219    4767            �           2606    17166 +   prestiti prestiti_elemento_catalogo_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.prestiti
    ADD CONSTRAINT prestiti_elemento_catalogo_id_fkey FOREIGN KEY (elemento_catalogo_id) REFERENCES public.elementi_catalogo(id);
 U   ALTER TABLE ONLY public.prestiti DROP CONSTRAINT prestiti_elemento_catalogo_id_fkey;
       public               postgres    false    218    224    4767            �           2606    17199     prestiti prestiti_utente_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.prestiti
    ADD CONSTRAINT prestiti_utente_id_fkey FOREIGN KEY (utente_id) REFERENCES public.utenti(id);
 J   ALTER TABLE ONLY public.prestiti DROP CONSTRAINT prestiti_utente_id_fkey;
       public               postgres    false    4775    224    222            �           2606    17187    riviste riviste_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.riviste
    ADD CONSTRAINT riviste_id_fkey FOREIGN KEY (id) REFERENCES public.elementi_catalogo(id);
 A   ALTER TABLE ONLY public.riviste DROP CONSTRAINT riviste_id_fkey;
       public               postgres    false    4767    218    220            @      x��}ےG��3�+�O��^˸G<��*�[�8"�Yc�/`Ȃ	��*��?��?6�xdUz �(Jc���Ldf��_�w7��)YcbY<=�vWߖ�O��������n}���¢X��i�����Y�fc�qi����m�����zu�]�n��w������7Ǵ�1O7[���.�8��{<��~�[~���y����1؅�n��-�\r�6��G���V���b��z���6���������\��"d3]�ۓsɕ���͗5cw�b~ۭoxO��\�����n�d�l����ZV�����v�x�L�w�G�^o�O>ެ��/?,��k}7�շd�[~H�/���W�&l����Ѥ��0�dgK��^��'������%oy�_�?�WWu��������������{X�����oR�x���,L�ӆ��cO��n�\-?l��?�ߗ��+���	��p�ų����'����aw��u�˿��~���'���f�)7g!���6�����&�-�0-�������毼�����Z~XݮN�����D΃�!�"yw�:��m���mn�OW�-�w ���bH6ykC4��������n�����|�ۆ_��Q�Z<?c="���Y~�Q��^�����}�ۗ�������܈����N=��LY9�).�}]_r�!��x� AU��CB�1J<��q���w��G���m���r
��������K�}��2���Ǿ>�cw���T�Y�JI�_���|�_~\/7����-Tw4,����Sr�vJ^<]_�W�7+.m��`���P%$<���y}���ϯ��6k9D8�!�W
�����h�}��q���u���Sި"%,Z�V�����p��R����~Oi������Ű���}��{�̓���v;�S�vg���x�}yXĢvz �!�!��x���]�ș�܎�,�]ʤ�!Axc� �:susq���vu���A�g&]��8��[��Y]��qR��Zܙ�<,��O˟����������͢x�v��!c�].��o�_V0	��n/��O��n���ii�Zn��94J
��xH��\|?�̏�������F�:�.�ʬN1~������"�l�;N�+����r]e\+׀�ƚa��{�	������v�ܴ�8���\�ѝ\EE�p16?`�N9�})f��g�͗(����r��C�Ն��7�`<�-�\^�!!a])��W,pv�;��1��2l��W�eV#�>�5�^,>l�W�6+�ƛ�����EV{��K2v'�GZ�?6�����Q��z
6;���_>-_�}Y�O�����u��Y)�=���5�Z�A�8����,A�&,���\�t-��爵\��:����,��=�U��{��" `����a�m��O�<��Yl�Y�<mP�3o^����p�i�?�����Ն�HJ%l.�������xй���8b�M'�B�22��TW� �4����>��7�8�i�|����A _ÕX�Bm�� oa��I��3���?�7�|���'��7B	�gM,�;��� i��h��V8����f����y���.Ɓ�e�V|�ǜ"�2e�v� ���u|�"�@�g� ����c:��i��M�� ǣ�_��͝D;S$.��#�)�n�x]X5������=��u����]�݉g�^�Bh/�;,;T㼂����z���������G�Pq�Ñ�qJ�94_�@I|.Tc9��Y<?�ϔ��m�$"��A����0NCq���^la���j�s�����m���L��4LR��&��1H�����r�j��Z���96���
!Hu��a�7���n�OD1���r/�ᙂ�,��':5,�����a�c4t~����t��m��0b����ʞZ���z���m�[
�S�����?�{9i?��L{O�+���h�o%:�v�^��hKu��0��~��ӟ�/�5>��:�7�
�Q�n��ւ/\����a�'��w��_7�א�-�
�
�1�ݻX����q�+�E��k�!�_�e�	�-݆������	��<xPn���<(z�)�
��-�`H�׻�ͪj�0}<Dk��;������7BL5]L�?b�a]/�M���`�C� �,��W��o�a'n���okL�%��#	�fᥝ��f� -��-���&y*�/�u������$x���kF�PP:ی�[�^B_��BB�H�����-��[���p�S�|ss=��)����m0���~���Ũ���C�xC��a����o����^}���d�p���&8�a�V��N���e�5��<3�Q;�P�Oi��� Y�K��"+���SH�U]bhzo��7t��>0B�%���7nj�����xG�6ؒ�'*z��*��X�Ww������m��H�oM�p�`��io6������� �'�b�pa~��}�_]^�6}Xm��*X��I:�@$C:��ي�߬G-�΢�������,�5�8A�WHͱ��g1���"��v,-^mj�wK�YI�CY&g�X��%=���R�6d��{�}��a7���]Cվ�6z��%��Xg�n=�[5��Ɗ��������T��q���_�/e��� ѩE,�m��G�;�_��v�?v�q�s0]iɒ�����`t���!��(�(z��ІCr��܈�|8��I��v�����Vh�duy!�D'n�̯�Rt-��ֻ�"љ�0݄=(']��^a�w[ ��pf�����X
���%T��È��Y]�Hï��qU��h'e�hr�Wy;����ā������v�����������=�~;��ap\|Q��Ot�b������;- o�/��J��>ñ��qsp:4�RO���	# �Q��L8yaM��}����^t1t�q��E$��{�Z���Ӌ��@>AT��<�����V��OH�!�K��Bi���P�v-B~Q2�7�������~0I�x�п�(�U�%��A�Ո��u������Z>����T299�|/�&�y�p���G�񶛂��샳����n����j#9�����e9pPAo����ÚA^��R�te�K��.U�K�@�U��0,XF�-G����3���b%�L,V�~�`����p��ݴ�D a�\�|ծ���A�|�J<�X�B<��v�<"��gQ�h���.8����v)�g�X������-d���rWU=�{�O�qԳ���ܯw�n���3������vAy8��� l)΢�%���\�u��l��o$z�w�!2��F�g��{�z�A�	�?�(ds)���.��ǜ����9�$����Fl���Q^@Q���E�����N�P�-�q0�*�W����H���1����J�bkɫ�z��E?Զ���/�DNM�U�>|Ym�n�<Wo�L�V&
"� ex��y�m��">P�Hp��k��%�Z��Y��D����q����<ʿ�����~ǘn�j��j}�:�$T�tG&hi�</Z�����>�!��k�����G���}>kT�i���!p5�Y�?g��D\�1����WB;����T�n�
R�)R�u�@�w�w�'LUz�g��+�<�Dh��ЩF�����au��߮��袼�����_U�W%ѝ�	��f�Ð��Z0�Pep����PZ��������L���C� ����#�޲,�Ș�u�6Q��� V�Ct6�J�r#�I��	Zx�n<������Yoy@�E��	"t�&yDL�����9b�$�ź�}��0���"�̰�~ԛ�o�b���	�.���R�pY�i���HS��dT����5�Q�ʻ�A��Gx!=�HlcV�M80DS���
r3zE��jN�A���I2�6Df�^0��������Z���KĊ���2���1 ����ҹ̢L�0�ߐ���"��L(�L�a���`Rp���v)6������m��p"��$>�6s$������m&��_�?֫����_W��    ��|nR�ؠ�pE�lZ<���L�XJ�*ǝ�`�N�]�,&�٫��H��K�mC�b�( � '�0���*28j�R�^�æ��^���m�偃��>:v���f�Ҕ�#�50�_����B��Ay��$FH������������	m�=�LҊ�0?���L��� �P\�Sϝ-D��t��Z�@��$9��n
�� ��\� :^~��/�?@�S�g�"&p
3,�8[r�pEO����Ä0ˎE�;�ǲ x����o���y���l�FO��v#9"|h��+�(��B���7	{�L.01�t ƥ8���<9���[zd�����tx-�@O��ާ
���i�_K�T=��z9Rðq8	X�����}5���+H��G2Ͳ��}�'��P"�[P��|����:���{���Z�]A]����������b�̜�n T��W���a�5]�}���R=�P1.^\�V�_��^��89��� <C�}��O��|��;���
�������r����A������9p+tAx�!`J��8��H]���e��(Mn�/�-��["L!��օ�<�����=�OX��ww75����i�@x���̛�S�$&Kx2u�,�!�F���N�����Q����?V���Kٽ��q�|Ò�q&h�$ᅹ`@b��s����l��G�!el-A@K����(��D(��q{�@G��R�$�&(���ty��>��{U�P�+��g�A!n���O��%DX,<؊ŉ������R~9��ę$;�*�I{�Q�?7U��t'��F�1aEy��=��������d� za�eY��=��J��RV�r��d�k�>��ȃF��tOЁP�0ay#p���k�m�'c�$������<�*I�5${"~�C7�LJ���W�(��|��ߟo*~�˿�B�]����}6� �O��:���� G����3�����IA C�.o�7���e���=$.�p9s�t�@��D} ^7��������%�,�+���'Q��j��'* =ɓcg�d��D*��A(.���8}�H�Qj 0�#�B�����S�i�����fr�a?�6��w$�����z@�!N��N ޔ�Ƙ���,+d��d`�շ�a1����HZ���Í�
1�0�g���V���Q�	S4�@�9�u�t����氹��Q�K�E��&H&�>ٽ��R�l�VE�̄�#�uc�u���e��䙇�IhxhR���U����3�.+pLn�'Ț����t`��C��+X Nd�����~>�v����!�QJ0�m"\��=h:%Ƅ q���bf-A]�'vF��'�*a�x�����IO����'@LP03'�ԩ�b	 L��I�g��}�v>V�sZ!�G�������W7�tD�c�e��I��t,����h�TX����7X�ajxg��J��b���y�341ȕ�4�dj��h&�����e"�G-f��*XǤ�BD�����e��	��a�JDJO���P��P%:3��B�ډ"Ki`���]�g��� �&*������ܽǓ�N��>��'E>���!|/��s����(t^ ��[�e�O}�}�H����7�W�N.���NTf�ii(��'�{Q�NR�:{Ѫ;�D�S�W�'��@!m�8�]�Lx��bz�x(!�����9	�0��]xj:�h%�BXb��l��G�w<+�)��&r<��:�^�*�
R��@��2;Y�0e�l�X��TxBDd׫-���g��oj.G%6-BX�ʐ�4�#m� e�J�Y4ɑ^;�%1
U^+�A"-T}�lC&?)<�}���:�l��A�hΞ����:E}Cf�cܣ� �Q��^ 8��X60}IED��%vc=A�K.G�?���.y��8ߒ�+�����k����o_�}�˘����(�GaXm{�~ɒ�	##��IՇ��l��\GR��|W��|���t��Yr"����X�P]a�:=fv��L�_��Z�l�Rzy��Uuu6�����8!�J�9����vą`�^b��!�p�A(��K;�C=˴R���Axf�0�T'ᐆ���L��!$��%���Ȃ�wd���L�_���-j)ATS�`�ՙ�۽&��x�-B�8&�vb�w��~�AK��,ΈkIj_�HB�/y��H�,�$��rP�T/O���Ŷz��'@�S���1�D��ʖ�yr��z%�@�V��8�pt
U����w�p�^�	Jv}�|;���l�Np[�J����I�pBl�
�k�saD@L��~{�]\�f�YN'�dC�G�%9�_��hQ����T2MԿ��"4:�f��B
�2�z�I�ҙ��}F�s& �v��N*�i�=��y�:~3%��I�;��A�����D��x�X�s��G����E�T�s�wba0��N)��9R|_?���#3m8Z9u����QG�Bx�L���3L�9�Gȧ�?.z���L�z/��R꽎!�^�Q���=@3��9����A'���jG�>ϔ�@�)B(	�����/�i�H������z���c*�j�	�s�At��?��	#�:�Ej]��5?��ET��Df�q.`s{N|���ibh��� i�%�E��	9ff�h��E�������L����&I�T�����:����A����ّ�29�&���l$� r9ێ�7i!������Oy��j�23e0O��Mz�

�"]�RM�~e.��8a���Ĝ 9�*/����m����,̅��tڑ Dd�
5�{�%�u��N`�[�<���q���'��D�Z�1�<S�0�B3�� � >` �ۡ{�S\Pwp�3WƦP"o��pO��rXW�$O�$����z��s[��#�$��h=��^}Trt�)H�C��T����~
-�Flt�C���qG6"��{Y'T�kH͏��+�E���^�9��ı�L	<Na��cc��܎�z��|�$��&���/J�IJ�Q���ᑸ��o �����3h����/��3�4c�&>����N�I����_�k���pL�xpD�$�K�;���3��lD�Me�o�=&��a`,YTo�ˑ�$�\����i��nA�����o��ab��B4������g�MZ�!�_@F��am�f)Jw_d�8�$��MS��I���'~�l���	z�"A�<DA$� }��n��[uP�%Nc�)F�-o�dƖȉ��ժ����d�uU����M �0r����*X���r�.K�BHgl��;e'�����B����?և���v-Mtp*���с߇�N,�x��vr`��/_�o��ɞ�!�$B��Pǉ��Q�؏���yY�IL�̈́��ipǺc<�(��.��yu����&����I�9�^Jx斸Y��'���!^��r�[Q�?lY4�{-�:���f�C0C�t���3xV]uErd�-]5N-6d%� ��`���L��F�	+�'��	�.)KU�Y!��x	R���+҄�B��S~��/ӵ�H4�y���R�21��e�1�7]扳�Ô�a t��S�M�FV`���hr4�hs���A�Yq<��#.��̪�}E�$�C���y��ސjŋ��	�%A��F΅@��z�ā�|h�N]�|��^��d�<�NgRF'��������x����A�K`M�G�r��ɔe���t�$Gh����f�\_�w_�/nF����^ ��0��ui��H�K3��k��E�1+��dΙs�L�OD�F	�����ˋFRf�t� �,�������{��T�)c�f�԰$`���L��f�s�<+Ѳ�Q�@G��7���ZO�����0:�����sA}>Hxb�wI@\Q/)I���d�i%?������C�7`fĎE�����X6�#����3��#|���%ُ�8I��v�@!|��q�s� :���IC,�))�c��[��
�aÇ�S��M�&!�A!}u    Ι&39��D�|
1���O��zAq��s9{,�ʑ�j�)�D���.9�@�KUD)��;��� �΂�4#�Gx}����q�uTӓ��w���@$��ׯ�/k�?a�_�j�B�������L��n�7� �<�����a�O�R���}�+��� �Y�&�d[
,؋�����b��R!�~2\cԥ��.�O������$�;�@���F�YB(�tؘα���E/T��y��p\A��Ė�d&�[�m7k���(��`Hwũ����ό��k�����A������3���N��:�j�"y:u=O7<[�琥uVN��2^p>|����ORZ�KE�k�#�z�����z�?|�8@��`i!ؾS.�l8J�=�c��b�?�u�r!�ed����9v𠾊^iTe-�;�*d���RԜ�K�.�n�6��� U�l�C��,���B=�4��c,�=�����R����K�8�{R�a����%'��~plYJ7�� ��J�\�c��t�pQ]��!�	d��#+��z'v��L���c+����L�+44��x��Zg���t�E��C,TMEJ؎�B�4()d?:ߏ��T-��4Y�hfܯJT�V��P��	����N��AV�8����wr��)j�>Q��@J�yN,�[y�,���<9I�ihE��gϳx���Q�T����hZ��QyV6:�g�ÀMIy�X��*���Vg�'� �|���W��E�?G�S�t���YR��!��u��록RaB�F����<��+e��M�'�8�����t����dĶ!���I�Q�9��� �-_�W׷].UP��!����R������P����.�X�+6�c`���1�z���	���۷�T�/I�t�F�k���>�� | ���U4�QG��CfuBaB��jC4��=H*_Xw9�
FE�Ҳ�!�t'ѫ eO��=�ϩ�WS�ϕB�/b��Yr"�

Y��������T��)��I2���1V;�Ԁ�QE�1�HG�qe�i%x�1��`Dn�<�Vp����ءe�!v�9h��I,=d�e�Ջy>�]�	��]���n���Mo$
�W7�{�����"We��n���-���y}m�H���OgJ�V�Wy4�	�0���	?�\�r�/d��O;'6��V�8���}����4y��B@G�Ij�6�'X��0K�4�!��V���e���#�,?-�L��l��qeU3���4�8#�qkս���O;���v�l�a���9��y�ϛ����a_6/L𳍟-�1i�{��)dq !!]:.E�a�PR�4F<v��pH�ՏK���<ýNp'u�9�����u[��2�X3���?�����l��".2��N��^!dM/ �	m&��HS4�L'"iW�{���~v�\��Ph_���nrbtۋ M
��	����S�H�Ur�J�dg&d���)��/1�p��	�)3HP�",,;��n�XU�L-Fْ>��'VI��$�o��4�N2tӧ�U_�R�bf�[��C�aA�Q��Ö�gC�Rf
r�`���y�J�X����#��� �H����t4�K�sO0��dצ[C��TJ���1��\�v��"1U��@� >���*'4F	#���;�4�v����"���I�H�9�TZ3��;�Ĥ��~��t��G�W�	{��E�Q�b�e�D�Cַz�9�9�9�M9��jr3\[K5?Z6
�7I_v>c��P�뽗)%�u�ަ��`L}sk�39����A��? ����?�nd!I�49�1$��'�X����X׀]����lde��-��A�Qqd�G��00���n8�^�Z�L��%�(��Wr` K�wBE��|2�e��{r�pĚ��ґ�-Jܽ?������#���r�@n�� �S?�wڳ	CWg3�[�g���ل.����N��]��,�H~)�L�D�`I"!������
�|�!�4(��۳�Jٍ�Cx��XxJ-/��8���Pb�Y���8�U�Bב8���o�eV�W���n��.������Ժg�����~)�z�)����µ��J�p�⌶�w�5V�����r�УجY!R�&���А⧷O
�a�X�4S	�r�eh	�>R�k�h��ƨ5=*I}�S�'��:Ѓt��b"�@����}$<C�ZNZ�k�B��x�W����zJDB���yi7�Z�����O��Y�L��+y���lF�{�o��i)T�Ԗ��ۇ�?�_ח�-� �g���
��x��4,~�lwrT��ѱ���ށ�YK&}���"��!I������yOz��y��5�8Q�e� �3���*��D�f�kDc�c� �zu�T���7��ƫ��\�9A�܍�p��G�a�>�R�t��I���'��,.��������ُ#&s<'%Uf���N�+60I�i�@Z��ۏc����f��yo����J@�Av���	IH�i��Ud��\��p�3fI��d�IL��%���Ӊ����|?uL+ꨅM�¢�;=;B}&�@#���O�s���*�AH�g�1R�#X��A����Nc��\K	wt��R��P���eSf�0x��i�9>����d��'��ѧ�h��6_���8Aa�*DBDÃ�	�ᓵ~_�w%B�? ���J>ՍV,�@e芑�g��"�d4uY�KO �SY1�f�\A�M�w^�!R�q�M��4.��}#�3+���M,E� v�<n���j�U�`��+I:j1O�i��ҡ�G��o"酗����"��r��W#m�{x0}D�Q�B6�*�ye�@�y��[I��uX�G��;����)���Vy1͋y�Bp�P.ΧS�1C�ɩ$ ���x�}��[�ډ�ٶ�+���EbI��~�
�6+ �K"y�$��nE�Qd�[@C��GZB�#�pFpXvη�l�9\z9o����W��$��1	l��q4����E���eO2B��nmw�T�b���r��A��Vi_͢�B��ISA��Bd��['���X}u���
��٣*��wȌR���U�|ޡq���Dip�:J�	��&ױ�W�3��mL$�H��N���P�H��j=�u��Ef��T��O�b_�qN�q~Ϝ�4��ɫ�x�R����'H�_�i�~�0YDv.��~Y	6zkmM"
��{{<���B��%�%���
z���e�B�F��tP)�h�u�f22�ޏ{q��آ�4D�_�Δbq$�>���#��D�#���s)����vjζ�Lm𢃁(#N"V�0�$)����!p S��$,�{n����O�Y����VU���#���`��#��O�9�7K�+ص_� �i#-8\�yYD�q��9����R��iI(᧖�M���ʼ���Xl��� @P��^I9��i� ��K�������7&4�/��٢�M��D��p��&�8�s�Ⱦ��~du��[O�!L��Ҋ������,���ٞ�W�YB#Z���<L!i����~X�CY�k�X��������Ȉ�R��^������ǉ����a�����N��U�3��t������v��|/t�����\C�6�:����D��	�h�H���uo�B�����0���c�]u"�p2����.T�&ue
�@^��8G�ڨ()GNlPH���ND:�;K����:+{�;�u\s�dx2��ܗ��B����m�:f�7���n꣸��	$ɒ��ޚs�X�H��H�D��Ҋc�x E��&�M@�4���;5�����K�uFV.��1]	�<�L��A�"��gn��V��S�Q؞<�.�EP�]r�����SJ���1�ƣ5��bfҌ(�F�49���0��o��(̜�Ξuݒ")I�/u�8��>�=�J��_+D��ٱr݌�֛�� �K��N&���~�L�5wx	�j'��4�v�`����<c-�q��|��	.9������QF-
2X=ì�i�yr�s e��笭��NgUx��7�Of�kr�C��$��/�4E'�mw=L�H]3k    �靝��m�ϋ2_Y�r�E����Lm�el
��w3����v�I�2J�$O�(��}\�y-gϚ�:O�q̲4��̷4ڎ#:*Y�ͷ�p��9�jf���,��<�Y�4w�m�����rR�s�T��a�2d��h��ِ�<sdCĔ�<���j�=�p%���Ef������Ӕ�����I�z}��x�X�2s^������Y���Y�(հ�G��:!$6ߔ�]�Cf�ai�O8Jǃ*�<�Jg����V�X�86��Vf���"I�D�\	���c�S�U�;jҚs�Ύ��Gpb�Q+�Te��_��vV���O��I�n諽�.����}V�$���xH!X&(�"�/��Ƿ��=���}��}�$�GX)#��;�+�Nhv��B(L�u�V�I����ۀ�z����-&i������f��l�aidb4̏����v=���r��~�D�S��N��m����j�$	�2�<�9��6�m�ވ����+b�n����m���m��~*��f�3��C�sJ�?�rg����C�FӦ6�f�k�{��4h�BF�"2x��w��S��*7��#���?�,�,y�I\��`�%(��&��W�jۯF����*����:|j�.Iʟ}$�Mw�3�g�E��"~��o&e�)D�OI���u�(oB��PN8V�7C&�	�$����srs��_��q��zu�'���,4(��왃p�w}�5�8\�+az�}EMͫ�D'��RI��Z5tOp�fe�
Ǫ&>ҟ^��jp�!�
�2n�s^���5��4��3���X4���C%�8�۲K�QX��H���f��R���z�sp�Ō�J\cɽ����A ��J �e��%S�̽ƹJy�&�b�>3�_N��&����2�	7�v*t�"��s,�mxi�3X8��|g.�p��0������j&�p��,'C2�i�Q)���0�Ȗg���Ѷ'�Ke�9�̞�� �Q2�����Qa��S�IʣE-����}CS"k��#����q	��eL�2X��v�%H�ZڅI����i�WZ#)I*�Y�%x�_ȋl�l�_��K���L�'��� ��C*�B�vR%o'��N�I��tf@�e�˱q�6{C@�eb�.��������Es�(�X��0-79E���_<ҡhdk;(�Z
s�� �^ͺ7�X��XQ���*/�M"	��6�>����,H<ֲ!�m��
�P�V���)!��qڣ�L)��p�"C�q�����V��+X��XL��JR&�R�E�����J'i��C�'�y<')�v�� �\Ka���R��(K#��>&��u��q<Fl���'	/B�^��;���ZH�)[�/�zu�%z�ZF�-�x1�쎲j�]K.�t�<�.I+��q�����+�&Y���(�8���GF���Tv1�lE}����M"c2��4�J��Yz'�����h&�dts�rm����Ulݨ���F�Qg1�q�/���H�49 l,�X�;�	eR�!�9ڼ;��`��=o��Xg��s�I	��Bس��}�"\Ȟb�zy(���%)�f�b�-r\�����;f�����-.���0������f�թ>��w��C
�L҉1��/]�N
s��$mR�G}7��sp�jѓ�.ď�^S�ȩH�58b��I'̨ rc��Ci��f�N��ڧ��Ej���}��H�sd��J�E����\˙p�����D��Fcs�Itu�N�=<2�:~9�����aȮg�`9g�w��{���6`�Pg���\F�!r�}���#�C����<;|�P�S5X��77�/��""fm�����NB&���x_��H�=ij4Кe򚍤K�n_a��������͝r˖�ıP�T?�2��ij�Y洰�(��~�V�UY?��LI46�����I�ũe�}T�H��1)�0H�~��LA��veإ'3r:S���-���#�DZb��~W{�л��]$��<����Ś�" ���0����Z�jar9� a3�Pi�yyN��^@D��(A��Rd��Fna�,]3��G_+����L�R9�t=))a=�{i���V���$Ki5�ɬ4"Q���x�)4���ͷ��ڳi0���Cq�>)¡t��a5��6p@b�⍑�x,Ș���Un�����a9�l�qX{'6��AD�������$ճ����j�$י�7��k`��J��`]����ۓ���{����V�"o�\��h�f�P��n-˰� -�qˉ���W�����8���g꨻w<֋2���|�c��Ù"o��UJ�eG&i��pzgb��k�v�{�[��Cc�(ss������p]'t_�ē��񦂅�5Wer��3�2��5��yp�����y��g��U ��g����\��RD�^�q%�]�Z͕K	�*��;��}l]��+ڬ�@e���_K>KU;ua1�Y ��X���y�ݙ�'!'���d ������H�)3'ai�ѐ�-���9`>�Ʉ�8��]8�Ǭ[� Ƶ�wc�W�K�9�-'S#��ΐ�D��V'�u��<Nh���c��ݯ��?qAޓ���'�6U�YƹX��6�e�7�d�;�ڱ;ʣ\�pAf-�ץ]ꕸI6��46qt�7=��k:����+9��<��L�iNZ�N,���8��Q��!�R��e�|��$X^��R�ZcJ��I��;�c)3�9<�KS��F/E��}:�i���d[2�J�)³<�ɜ}c�/�J�{gA7�э�%��N?n��Rni+��%�i���ev�m]ON�	|f5pi����яH�9	�x�nF����9!`�������8�D�mA-ɚOd��~���͗��X�2��Uġ	�s��oJtO��3aYkI P�i�ҝ�L� �5c󋙘 ��.�Ql`6�~f=\E(��M4a�8pl��Q��z��S�`2s�)�X�e�7��.�)=>r�^aW�f='a�?��B��˗��4�%��s�P������
|H��c~U9p^F��'�ۡM�ӯ!۫� ��v�b6��'J����I����e��\i��Xl��k<��>Id*���3�]W-���c��	��3�5�v�RO���w��Qg�j�̲n�;x� ���;SG��K��cf�a.z���&�E4�ŁF�o�=-ׁ08���l��Җ_d$9�)�S�]g��.u�ǭ�c�����g�=K�3�3u�r�4ʄ�$m��!�X���D6w<�Ԃ����RAH�(�h�8\dǔ��16��s6m,���>[Qp�i�ᓆ�hE���@Z�~)���������TZ�@� ��}�~Ϯ��&�]�\��H������R�l��ֺ�&��ǥ/̯��&� �cI�󺐅�ͧI�.Z�.FF:�~��!�nF���+IZ�V�� ;��ys���]���d+���͕������ù�s��s�}�J�P�57}'�Ag�nD#��q����:��U?e�\I����.���0\�wy-߬�K��~ڞn��%��������u'�e7=��2�,��]��k[����p�'�����!+�g2	����ҟ�����"����N�׼̛��^�m��мB�JTN=
�ӌ͒�Ҡ6E��l���{������� I�������^-�*�M����Ƽ����r�Pq|/��6HM��,C���p��غ�vcEh�E����|zU������8-�y�^�K�D3T�À0�!�ͻ��K2e���nF�^8��β���s=w��,F��$���'�F��y���[Cr�ht[�����1,���J���{���R�KY*�!jP̧T��]��-R��Dq���W��Z �(�s�~p�$�ְ�е��8�L��JG��l�AA�����������Lۤ�Td�t`�o��l�ɇ���lp���<&�yE­ę�ޑ�x��m2��ϐ��j���9��a&��!�3-x����v�|fҸO�V:���#��<B��L�\!�NXz:/;�_+�,��i� $   �s���� ��yz���i�(��3E�Fi[}�P�K��z-��1�����Dϑm��\���[K�w��S���_G�2�%�is�`�8�-d}��W��G��g�UpF�>{2�G����L��
fkI�q֔��"��X3�H����ۢ��b�)�i�l/{vZ0[�덬�i�oD�):Y����;�xW�v���h��C����G�{��#O�@&[I$�������7�#�[�qm�$���u�]չ����E[�+ጎ�Y�1Po��$���s�K�ދ$M|
���z��=�?��ɴD L-��c�2R ����%�N��=����o)6l�g��a_�db�8�������c�꜅����� y�{����6�O���׊�~����pOb)7���u	���F:�X+�J9�RcmB�Z� 6_�797.���8��F�3�|�Ε��z ��f�p����p��XH*�:�)I��*����~f�c� |]h;�2։=�p���rRo���F)q�.d��*�������E������&��{�#pg��E4{qVƻ�����;3��Z��OJA�)��t����b�!f}�*2+�vk&ݑx�Z�Y������]_��)�f3Oq5&��I�԰\T�p�Ԧp�4W���sH��u��䦬���5T|�(�myX)�f�^\2}��4ͱ�"�<�Y�f����<�����21�!���i!j	{y�S�Z12�W�cù<q#a�JQ}jU0��r�b_��V��Voy�K�m�m����Y�5�d7z6�f!���U�G��$^�1��;�(�z:�������d)qR�쌍x�e�y�i�X���oH�
A!H��\Y	Δk�~�ܑ�y4��U+��=Nf2�<`N�;Je�m�]�R�h!|s���U,y��=�wEb�^<�쎜��o8bSJ��<�]
�GZ�v��˨Q?�g�ljqr���Zj�%%���E��R�!ZZj���g���|G�t�ƐI�"��[Y����8�lPU+�����t'�3|xt�crΎ�÷%�!8U����_~X�}���/K;�Ň�1F����/�xГ      A      x��\]s�6�}f~���[�OQz���-���Lf�����02*�"%W�_���n ����ĤH��}���f�4O��z�۶Y<��U�Aw}r;��߿di�%��Qmt����M���S������UoO��j��<�Ԍ���T�xl>>��Q�z{�}G7�c3��M�u�ǿ��}��͛��Fm��y]\�c��5�Vх*�~]���m�,nǷ~Ը���V�G,!x�2���]ܾ7�^���_ߔھ�]u��l5~F�z;�V�����5�b�^u;��N��l���ōZ��DWR�ɽ>�XrO�}�������6mxk��7�{�0�8�g�+r�����Z{��K�Au[�����t[a�dL�,�)��cQ&_�~fk0n��J����1����m���B2
�plF��:��|�=�Ԡ/�F�J�{�X{d���Y�O�Awxҵ��N�z��2Mnts����>��ɝ���ah���ܥ�d3d�~豾�]�~s5On�Qñ_��~�^���zӴ�~����me�co7��;�e�n���S%�uߚź��Z����aN�ڞ��f����;a�����'�c1c�#L�w�*���^#���'1��c���Wm�����*O��h�1�T��'X���W\�����QI�ͪ�.�A�&�쾓�[m��o	+oB��k�K�����{���C����+��Ex�F�7�g�D��;[�\Փ�/S��?��	a`��'/��q�␎�2�����;"��"li�b0#������S{<�gO��kY%W�"�^�r`�z�[p�L�z��A�o7ꨶl˚������}l��*y�@�\=l ���p\��
��$N/8\��G��������b�U@�Γ{Վ���w���Mu��������
{6W�޿�5��6S��%��vMg#�?�\%_�8�f�!Ttf�9?}#�(���.�}U��w[B��O�ٕ��3���4;?�z�ck�[�OWir���L�&Io�D���Ϊvq�r@p���2 "v����@P���^`�v�`eb|O�(pi���������9g�L��'���1Ӎ���x�i+ AO���U�?��7^@�5�����c/����9�:M�wP�6�-�Βܰ��^ڃ$׺�Ӎ�v�l�����s$��MΡ��ú���F^:֥�����������˫��@��݅g.�/-��)MY��q����.D�+����19��G9��@iv��,M=�>��>���4K���&�ذ����@p��gx*�p^������^Y��q ��� ��8�+wy�%d=�}��H��3������epMq{q�Y�à��Hr���?[�W����s��;c���n������߲,'��j]�Ò�D���5��-���fe��0���a�˳�|7.~��NH�-�(�}(�*��,�%�KFM����/�7����n�7�ӀP9��z�C$qhp2c,Ƞ�[�eH��VPE \H�Bs�5��괧
��2�<6b�&�H0eD�qk2�䡐6fPA� �(_Ϡ},���k<l �x��γUIt�t�c��rN�2����U��@L%�*��<i����FF*�U���@��c�b�o��<c9c,P���v��gB��Tv9��޷�88�0�2@�G"RD9�!��c����sAP�L~8��	��!�,��1*$����V)37Gp���:�,���|f3KMQ�$o��Bd�E�VcJ�@}&�'֙�1�>q��lUPA���AEL�J�=S9��@
�I@�.bwW�g�&o�w����n�� 4	����Ѡ��Y��O8c4+2�;�Xj���J�j�%�,���N����\/�id2`Ȼ���Xy>(ڲ��<, ��y��ध� ������#�[����Q���
NQ���2����� ��,=0Hj��%$y�q:F(!)��|��:� ]�tH�GWD�>,2kY[���h�F}V�� �(�S�n�q��f�D!�&${��8sW��µ�LB���3�$"�?�%'+:��$��5���}��)$����RY"c]�y����)k��̇�]>�C!
{eY17T��
F�#]���Gb��(�@%A&����x������>��k�۸T���$d��.8��[k��x��;���_Y�{��bFh��N�0�wJ��S�*h\��pr�HV�0F��]����
��e�G"�}Tp��)fPH�h���7$����SET�J�n���`'�6��PJ���9�bH&{2��y"�r�m����LrH�;2mg6Dt���s�9�]5B^�ꆥ����T�NT�L�wi1�9�(�z����3��ZQ�� �9���<e�f�v�~�]�)�����	�$�$����U�����Ō 9e$��""���ʗ�gQ�CN�*��"�LXl���\g��!�p�&K1�����v�'p0�Ay&Ԡ��1���VW㨧�[�K�+�z'i.'qe	�5^�}�bPN�h3Xq� Y.�lnoV�~?[}.�X9Q��)��OB�}%�� h����L�l<�_�[��'J�&{�������!�-�v��`�{���h�EC�1u�E��)�¾#V����匞C���!0ͣ9䗉A[N�����|6x�w���;9T֗�
[i�y �nL��k-R��!�|��S<�ȡ��]����O�M^���L�7s�������$MM�a9�g�ƅ݆ʂ�F�\c��S�T88��!��0e��,��Kv�N��l��"	Ua�F>{����#�Ezʼ���ۀ��sr^�rL\�
�SS=C`�ۣ{��6�Lj0�E9E�0k(�S"08�
�bpy�S�����vR3;�:��(��V�L<��^�c��+���d'|�=}ʗ$�αW�ȗ�/��]a���e)Uu��9�@;M�Z���rO\{u�#7H&�۽�E�PJ_F������w54�
a�t���r�ϡ���{Ǽ��=@�$`PG�ڸ)#�{|��7�S�Z�6Q.J��^&a�:G��ǮX�C��ޖ�-����w��
�� ���\�L�R�(�2~I�<���q9�)�>�X��e�P=�0�C%_Q�rcڞ.(���M�p'�ED�ms����<k뒗[/�:�/��A%����=/��m�,����A��~�:@�H%��ݡ����j])����7jM�vX �c��q��c�Xr�n[1���4n!pZ��λ��*�9��%�Y�T?�!��'į}�`�,��N#\�j��7�������� )�� 	�;x�ł��d[�lq����ເz�1��-���ŀc�,YU�7��ߜ���x��@����ۤ�yMaH�P��ĉ
(�glRho��q\@��q��vt����?y^T�}����bc�k��0!enO05I�2�E����b���ı>~��PY����d�����:+o�XQ@�4��=W��ؙ}KO�>&"j
�x��pNKV]�3I��R��8ɭoX�N�H����[/<B�L
961�V��w�g4b1%�LEj#��K�Ķ����F��U����(�nw��S~7���:�VCy$v�֑¤��a��h�.u�:�[E�b�k��6���\����>N*,�8�:�,5b;H��Pȥ� �K���0H���QC�H-����َM@�#Z��1inL��Fu�kilD�c�RA1Lz/�2���	P��A��l���9s	���-E�6���e�y��F�`�4ePr�[q��{CH����Ⲛ�s9ST&;mM{Ԓ皶�2]���'��p&�������:����Uk����%��M�� Z�2U�p����BJ��>�(՝HJ5S�Œ��23l��3����yd�
EK	�i��W�<��v�{B�jH79�&#H�i5�|J��MI��&���)��GJ,-
W^��=s����gG�"v�w$�� q��d�B�@*�Q�@ .+"�;�dGI�����in�K��g���'�   ��_��(�E�tE͓�z���t~�`3��b�=��7H�$g��е��\Ut������;���2r�M�
�!��Ϧl�����p��Bz&�d��3u��PD��۹���N� ��y&�\��-���W	��%
���a��b̔�Xյ�]�,n�2�\�%(���+��H}7UÀ��[,Y4]�Bٯ��8�u�c�eZIeS��%w~�tu�|eZs��/�_B,�^���d�51��^�@��,G���efjm=��`{LRQ��$�2��g/����J���G��I��)3�!��{uI�7a��d��>E[]e&]����ͬy�׿�\��LIJ�s�&�K(�8��2�A��x*���+��^V�� ����ny%�,�ͱYB��r�|�4�R>�����W��Y23�zn�:�W7�N�	9$�՘��i�δ���K�U )XL�y �ʂ5���s���u��-�HlYP��`�#���z2�M���d}�����Y9*h��f�}MmLNq��R� ��D����E�[�t��b���E�tN�TRWg��0�:�O���:�m)��ԓ�"����w,y�唳N�eY[�?,!��{i����2�`�y<n��a=�N�B(T���C�T�|+�G��%D��WFCft��Umyۊ� S��'����Z��v	+�%�RX�n�y{���5X�Eݼ�=�����:$�����r?�����b�# ��4tf5�ՙ�T�]�ָ����L�D#96XB<�~>�+�](|LB��]�ޤ��ugoz��̊��r��T�G ����MoP��:����]xfGJ"��CLAǒk��Z�2� ;��O�Wd�����s&�<�����m�U��c�m�Il5M���(BH#�U�'M%��'�8"�r��hD��S�7���%B]��ϊʕ���4�}��V�o�K��C���M��9ϩ+��5h�E���U�p���cea�g�E��L�=�2a���[�V�î37}(j,��'O��#([_@Tȝ;x�K�1�C�|���ُ7�!z찵�����PI�����׵:�2T��a~&��.k�\mSq��6?�*M�ڰ�]V)��]���e�Pt�ʋń
*�k9<��_�YD򍧦����N�nM��Ia��TP:��Y>4�U�Ů^��O��J�'mܝ�R�w���#Ư x�y��B��2�Y��2��2�o�c X���nl����d~�3O�Z��� f�c�մL�O��*L��ٶ��"ۇ	l����jdg�2���³~���*���p#O��]�ϯ����ja��      F      x��]Y��(��~���cf�D�����&$l���d)��AC($�u���Ɤ.��˧/��k�����������rh.�����y?��_�ןs��zŮ�_��/5��r������5�e��cy��+V�y8���I}TOs�����ƨ�/�ܿ܋X����ޯ���u���B(Ɨ?_�����R��{G�I��!����I�B�#�CF�6��ny,X���.������w���������1�����ɐI�]+]�W�����M�+]XW=V�"镡/�����-r%]��:�{}d����*�w�o������w1��]���k��]t~�{ i�]����W�����wt���I�D%Z+!s#V@��i]<�uuW�]{�:��.�/z��q����+�o�+-<�t�hsd��}�;/O3B��^헪T������1��R-�t��������R_�~Uy��QY�A��.�Ż�;g�[̹k���dWV�V6wk	�~�R_W6� M����}%\��9�׿L�uq_+�]Y@�h��U\�w��&��j�L?�Zj�Xs<)ڮ�SW�����wQ�����^p�~q��%�x�{ؽVh����$����%���j�8v�:��z�c�Qc�]s�*�w�O�U�6w�/�N6�����ρk���OR��V�5g����5����EI��*�}�*F����MG���������29�|eX�����Z�9�w��h�c�i�7���-ĳ�6�c�ߍ�x�K}�湒������R�f���s�K]#;�Fycϼ:X��V?�^�������
���UbٳWuQI��,�8�݋J
��q����zwm!�ܹ��A�V���:^�9þ�1�ޘ��w�w�'w�u}�徹�kB8������}����bd��v���r�#����{R �T�֘O�E7_��c���[���-���&E��6�qI����_�8�ex8����F���l�[��CUI]o`pݟ2�Th����2rs�N�Xǋ]x�)�hTx�u��L9�]�SA��p�q���L��t�t��3�<l,���ɻ8.z�j�;�k�o!��P�R���݊;}@V`vy��@}T�i�m��l�Ќ��{�7'�6�%�?�wv��~�G�FV}X��48d�zs�o���r�Ph��du�ת�oǫעvW���*�ԥ��k��!mY��D��|^uԾ+�c���Y�����^��*�XS���E'���jN��sװO��f��pKSEp�.�fw�D�=�뉠���՟r}�s�M��8פ@@ld`���@0탱+����W��%c�u�:�X:����a����,����lⰊg=��\}��E���8�(�$շ+dt�V"���ZN����F�ev�dE�sl��g8����%)��T�	>���:��*�w�{�=<���W�8��4��t�ԃ�]�:`�4.X1�LXF�~�-��_żF<5W{Sǝ�x�"<�0
�Wu���L��5Xa«c ��V��_�O]�J�WSĐ���ﻅ(0���|�o��O�Q���U\l�M��څ�	�^Y̴KK,�=�~c{�%Y���`��p���� ��BA]%%�X�l8`�֗*�G�}��egi�I���CL�R��'�.ċZ�Ξ�;ī�>MH�xӕ)����L*�����Iŧƾ�~���4!	��w��!��n���Æ���4�a�U#��odJV���(����ng,��s�<�w���Q���艶���lL8ƥK���hԽ�#P��|��n�`ȁ$��I�L'��X�����9��,�RŒ���㨨Xst��圦����ɅOU�cl��*L�ȅ\�!�/]���^����,qի�U�>Y*T5m=Q�*
�ȳ���8�5��ǮbY���
s5��&D-8kWT��+.s{���~ gw6��8��b� s�Zr�0�-�����@�3F��HG4��l�R)g�n�D`p�K��x5�8`�I�����x�ܶ�]w��v5�U��^�"R�]���:!������8�˦ʜ�Q��N�2#}�9W�]����~���~�&��6(������UdD��>����/��F�ٝ��s얭jE�WLp��
R�
�s�O��iC���������F��xTrBS�p��sրB�Cs`��a�lw���7q�¯U�߱H�{so�"+��nī#�r��ؚ����{Tѽ����-	������,��![����J��,�6x`j�ɍ],�f!sc��d�{H	n+�
��z�� N�LXPG�0G1�bC=���V����(��FQ�Y����q��v��n�$K������.D��r�^���#�E"��Q op*ċf��L�.9ɮ�7$d��_�
�ᕧ���+0���=T9���x�aUkTo��@��9��P�����ZlB���q��w�!{��N�����YI��P�2��.�^�BU� �n�c�MH �-H�Uh]<���8�a���ֻ�(`���	�=*���紦ϣ� 5T�cm�5Q��S������$BA>EA���J���E�BA���q%��/��Y��x���jߕ�\����~U0��'e�w�K��U�9&u��T^�(߬�>)�5���E��Q���q�U�Ƭ��K�0,TVB:�1yq�| vK�ηa�n}��h��&���z���Ir̀�U(�!����+���$�>������/�I�A L$�M����$0ja���t�-�7�k��44��'փW�52޷�Ud�ƀ��I�5w#r���W �]Y�-��6�1�8�v,{L[�L�;5��;��O�Q�}Y���YT��
��dB�:jV�zBmc
���E�ؚ���jx{���U�kfg�_9��Ó��Ŀܘf�("J�Ү'��x��h���9��0�Uߒ`���.Iх�N���{l��{Þ����v�%� f��	��f� (^�76�ǹuqe��'��ӛ:��֨<
��wi	�=�`�l�ӽ6����O�|R�KR�����:f���ՠע,��>�W��'Ġ�X�*L�#]��{��dg�Zz,Ts�u�����	(�Bѯ����+8ݲ�,�W�d��,�U��q��y��́��*&^�zڝf�n���	�囵*�L$�S�QT\=rB��A�)�K�s�Ľ2�"1�W����r���U��ʂ�XR���A�>-s�
����Tċ�ڙ��;gYq�pU=�-���fB��W܏=̍���!�K�4��S^�*��g9ܵ#�Z��� T�o
;��7Y87x�����wO!��"NZ���d�����X��0�g��H�E���8� x��PǉYf��B`A"��p^����p9�`�J�/34g�0H��1�y�6��8�1�wq���eR�V�W�gM#�#�&��ƕOV1�|�D:���p�|S�ˈ>���n�wV,#� �!d�|�jD`�]�B�g``p�']��,㨄;c���=k+K�T
N���L�z�d&ϧM�B2P�&����JRd��~T��ڵ9k� X< �����;���V\1>�{�+�|/u-dO,��(�D��50��ƀ�޹NO
Z���'�6�w��P�ò�� ���
/`����`k
 4T�R+�u�tD<�z9�L�]��{�|�I%�?x�c��*!�*$'�0%M�z���bY}��+�b##���Y�� �x*��@�T`r)&zת(��y��)_��0�RR�r�=v���ќ�rY�8�.����=N52]�b���@<)k#_���?���.|�k�]�*^����<;���6Ru���un�U.32�l�o#rvb���܁mTa�YUI���a�)������L"�֌tԑ���]ۀ�V�,5cR�|���4`�[����Q%���.�g ��5sZqa��0�]0����>� ��Jn3���5��3�L��i N�@��-�2���N��%�u�Y�pJ�`I���$ԁ    8���8A�ːD k�m���ֵi!`�n8i���_cpru>��pN~E�b�ۨB���Ԇ4a�[ބ�/"\��=�OBN���C�������+�M���Ӑ�D� ��������hhq�a���X���6j�v,�hR���cE��1��ҹ��#�d���|�^|�����|Q��W	�ϱ��?�ĳ��%Jp�@�hy\�z�K��uH~�VbK9����:��
5/
5���6��
�����_5%��m`%.�D-Z(�|�`�m*G��[u�L*�Y���cIo�Z�<�U?D���!�q�ȗ�q5Y9,���P���#k���%���}I��+d����Fu2��aH��>X��,����X�
�\d?=�ݑ�2�g7,Cjp��e<ą�E�9p����IT��}��LM���6����闚����"jK4~���ａ�W���xV��T���6��&y�O^&V"�g˳�0x�ڀ�H��v �@j�1��,CB�(7�3���q�q��=ɬ�G�X.|eݵgct�6��N�m������.C��uȝ��bg�$��66'O�������\2jaF��[��8��d}�Z`Yz�X�kZ��No��!#jK�pu��pu�"�RL�+��@�)���<���C�* ӽ��~t�Q�����@�J��\��"�1��X���g�HJ�^���F�ǡ��S��	���B���!�H�c�ı�#������-�g��t�7jM$Z![��5�B��.��ɣ�8�ә�r/��\>��@H$��b�1������f�"�C8���#���}��ړ�qꅿ!���l�[�,��Eu��w��=0IK��q��������*��U���CJ|��%Ƒ�S	l�o"0٘��'�㪡��xb��	.P2�-A6���ͱ����'���8V���2��O���w����h�w�Ԗ�TT��'�aK��^`���)�[�2�q �.��C�	��<}N���8���Q�!&�3l��-�<�ira���x���[�n����yHp}�<�"�QB�l�'|�#���Nn�bA��^�Е���t�$؇P��������:����:�s���րx��Q�ۡ�FM�]��+��?��EI%�u������HB�]7w��wK5+m��2ě�u��h��]��p_���	w�؄YM�6��K���qTƺ��!(s�'�7�G�L��g-"ē��)Y��� ����)�D�Ԫ\0{ȸ �(G�'��Ų#*��e\0����9$�w�e�����j���A(�U�9���F���w��.8���C���Ӆ�6�VE��D�<n#��zsp$R⌫�MF�Zǭ�Vį�޵*��;0���@;�Ԭ,�w��� �컛�`�1����8�!܅�_�hx��ą/��	�X)8���V}+<A)�q���^���?�G%�72gp5!���������.�]5���=��#��ޘ9`ړ�@4~�W����o���*�ڻ��:����?(�ui��$9,�;5��o+3�����9 �}�Y.�����AX��ܞ<N�z���j���Y��Z�0�݄�k�yRmą��j�ڔ�S;�$`��ՒඁEf�.�Ԧ����#�U�!���J�^�'C��s�>��������X��l�\�� ������}��<��\�i�g����'��Ѻ�"��X֣qQ��Ƣ�?yE�giB��f���+�̽�Q�:ϥXp«�80�$�1�NQF�"��p�;y���mH�����ŧ���.Q�Ŋ̓�!T�¾��y@JX<{�[��(�2�yvs��4�T�8Zx������!��6�T��� #�s���P��>��ŝցc=m��&V��.�vͿNb�PN��T�:x�SP��e���8�@����	�-0�
N��Z�m�y���~�o��A��(<i������P��w�Z�6z�M�x7Pa��F���d�}�l�ԦȜO9eXg���ٲ��2j���\9�I��lv� ��@)��;k�5I�p!�Xo���o D���^�0��#+o�~]/��s2;2����~�J��$�v���Mr����Lm�ˍ�4Qq�>m�- ��;�{�o����x��5�[W��4Hf�M�4H�,$�DU[�fXr9Q���yp�j�ݝ.�y8��H�52s{K� u���s;6XF��	bPXe�㍅�X��h|�hC#fy���� �{o	�mԬ�Vv�W���Ï"]����I೰��/xR��<�-OY6�����,o��94�vC_y�2 :J�a�,���;'9[�RW�h�}��M�!���kJ�I��u����P!Ҋ�k�gBT�i�b^&u俜��T,hk����)�v�[ˮbIÈ|,���ېҕ�[ } ކp�9�ی:��W�<�0"K_�57K��[r�秛	ۛM?Ru����{-����"�T�r�2�s�jɖ�%ē���Y�U��|cϠ�"�@����R����� ��t�Q�97���K��}7����8i�Uqq��X�,�չǚݽ�Fs�܎s_�� >x�����w� ��m!i��L �T���堦�H5�����W�D������i�3�H�]D-���\�x��d�ܔraˮb#��ɚ����/���|4�x�fE#���,�+���/l�\\������\�2���kY;�}M�Gw�6���kH����w�
&QF��l6}�q���\,�R�\Fι�=[�.x�B�c��A��6H�P������[PF��NQt.��rb�xR�쎮���h�2�M���0"S,?jX�4����U�k-@F-���M����S�����a���`y�*�F�\�wWu�^�ځ�j�0]�zw�<�ȱ��xq�m>�).{1Ac���zJ����침X�6^O�����`��C
��?h�����g)�6ޛ<�\f�q`�Yg�ey��ɣl���E�O�m;��Ln#�U8�������_N�pHvr*�\nj�F=Xe�b��;�����&�����>8�&��H�9)�+"����^V�'��3�;.� l:ᩢ`-H.�MA �X������:��}u�6�^�%��7�%fO�i]����6���F�k~�e�*E��'DSN̺��-�x��c�S<u#!�3�i�ĳ����.8�ҏ&�#�RX���j��Cd��A����T�d��{�����Nc��t�E-`p�w�\�F�1wY����g˽'��n�ۓV��"⣣��-z�t����476��/_��:�/T����f�U�*ba�����������#�Nx��}Y���:�t��~�b�ѣ"��@��jVp%�?�5-�)a���x[��บ�J�+���<ī��9�-�w��������fEHP� ��:�%����-y��������/L����EMxM�lIv��-�<��\|�ޢ�{���*#�{�"��ؖ8*e�ٰDGm����r��`u��m� xxA�q�:��_C�ݍ�A?4�u�ˈ�/�n�6���S�$�މ�i��x���Rh0�Ϲ�]i��u�K�o#�M�S.��4��h�2�Ԣ��&s0M�Z����rɃ	4|(u�6�)���*��g� B��!�#�f�]��-�#�s��#:.���*�%��,#J=�*Ƚ�6HO�kF�|�kr��{S�����ƹ��Xː�YY��� >8Q�wmAu��&˄:�||�`q�c�nI�J��+�w�D|dR�^W��?vo���s``�0�w���r�[�iH2����V���ol �?�	��+tX�0�ԛp�[�0R�y�`#��W�ܻkm5�z-+������6ez�ta ���1u�1���oH9�5U\` }�_����nq/�M�ن�1�yc����5׬@UGM�0?m(�6�W&�n�=*�q8��ҬG����Ľ��k
���Y��x��1���W�� 1�����Q�@��'��Q��C�L� T�oԹQ����b��*#7S�x�����[r��`�>a��X�C�2�= Q  A��#��ŧ�ntt��ₖW7<�PNqlu#ߕ>_�E�R]�	�'�u�Z�p||���!�{3�t�'�q#��f+����i��
R�(hQ�W�2�^&�4����m A迬��W?���et���{.�XF��r�2i_*���,�Ob]��Q����>�)�A�~�Ɛf�_�%ϕ-��G�1m�vY��bm<��=,�]}�iadNX���HC6֫�.����p^m,Z\	� �zn�8�}z�'H�!~���>��z`�g��J��a0�3SU�I l���^�Z8&��g�y��M�wQ��{��N|�:����!���`U�i �m_Z���� 4Ƕu�<7�'��C:��U$�j�܍y1��\I4j�
�3�j9��$�o��`��i����jM�А�1GsZ/����N�"��d1(j4�n�Ktu*�P�>�[�F�!?7��g��[�gW��� ��^FQ�/�dt�#J\o��XU�1�[1`�-�A�.�VzQŜ�ڑ�/~±ƛ��bj�j��ːy9��2b�S 7X�u���ҽ_�g���b�U�O����������}�J����x��z1Y�$��2�3%17&��!}E�r �e��O�h�애+a7]~��G/���2/�4�D
��&��I��&�6K�	��
-Sa�Y'Q�r'� OB��(���SG�d��5|�� �n��P4��NL��ba���q��`�i����\��Z��B��x�����DY߳�>�ϐYL��S�pn���c�ϣ+��|~7y�u�n�M���'�[4O	�
�7:��x�T� Mن�Lf_��x@<ސ����]�s���e�u��Uy?E.�W��C�:x��������IaB�zE�+P��e�_P17�p�>�� �5#��Gq�?6���������/��c�v�E��
�6�4�/d��T u$��̕�K���o�z�O�� ��t�~���C=#Һ���G�����5�6�C�<��$�XF�0�ލ]btg�>����*#ڀm '���Ii����8{M�G)?\�R+Y��Ƴ0P�����:��$|���'!>�i3o����:��%�����	-ߜϻ֤0-n����@PR��*64\;� G^s��ۢ��X�j^�^z��D�س�qg�Y�2�0�"���mɢ���B<(Yi�	��H�>$�ɞ=�4C<)�7Qy� j�xV�A�2�����4S��s��o�{(-1����l=!�]M�8��EzF�qI�hh����}�%�n�[\򣟔S��ͻ���ZѯA4�#dF,�`(?���>���k ����&F�ik����d�����O]�����z�=J��!���h���ix���7E�o����-�+�h�S��!su��Ez�:�4P�¯�o�(5��r�}�6Uz�JM�U�9Y�4^�����j�PS"/s@�o� �'�%���*M+ j�$\9�yx1&�� Ty�@դ�F���l���sa�(߀e(�I�����eA�ItO��ٙ��]�6�`�����VR������À��XnF�Z2�MwvRq��F鏮�Ԗ@�����(��}���R�N噭�N���D_��_���G����B�֓U�^5�^0\p��1)O��`�;􇗹q��]���zW�E����c��Va��0���~2�.� y�l�ut�wᓄ/���1{f=2��2���S�6��n�T�9�Q�UH��`��>4�	����6�/��n��Yl�D�s��p?V5��]~�eͻ����17�C�c]$�ٰk��ImI|�� �%�?��u��K0
C��.�1�O5��������?���v      B   �  x�]�9nAm�c��*ӤA��HC����CH�r¬�蚞`֎3��������_�?��́z�|�}~��-��������翳Wԕww⣌���������V���ʳ�b_Y�,��jm���E�I���$�A����^@���:�#����b+�E���<�U��\��V�_��M�]�x|o^��6�QgWl�Ȧ�	'K'�V�vJ6��l���l�v0�L<c�t�Kg|C�mQ��ٙg�humԇw.h^�|<�ƽ�5�|#6D���F�j��	'Ԝ�l3�����������%���E�4(���J%���~���#j�~(�����|�6Voqc�6�{�x�-�������|�N.%Q�D�$�r����V�S���Y2U�R��`�j�b����r�N�&]����u.��Kڡ@�}S�T%�P"[������N��f(����`�Sx��/��m���TC_w�+�PC_u��Y�S���f�lc�n��=�7����``����PCC54�Щ���q�j��i@[@[��.h�3/t慆>�L�AC����Au�`'��� ���� �.�hh4慮�׭�] +�U�ŤbV��w�;{	4|ЍUk�5;�I����	F� �\3��2aل~
l)�FPh���7͉4B3 ���Sؠa��.B!'2d �@W�V><>hBB<��j,�< 8�@�
�Ĩ�ɵ��r�!B���|�x ��IHZ�%(��u�(�!.(H��6Z�N�N�͞n�t��H��\/HA9H��`�
:�^�"�S$Q
J)��e�TheJA4�q��4�h�BV����bV� �A$	~Â�a�$(B��	AbjS�DH���HI)��A0�Da��PF�x�)��0Ã����a�0���9V���1����(9J��-h�w��T�3�8R�\y6��O�Q�$I���Ft�J:���N�D7�#:85a���q�7���0JN[xW �$�0�LY�0daD� �t��0K2"�!C�P�"��)?6�@V c�0La���f[�#̱��
��dɔ�)C�,Y������������pF
#R�0����5�_̗LK��2R������=�z�^�7ꃺPw�qe�XX�h��V޾�8Y��#�������������F$      D   .  x�m�Ks�����_�Ot��q�J�
m��wO��C,�0(03��~��* 3C��$��]UY�YH֙���t��<�Ƶ�w���B�5�r��7o�yy��0/��4�˽��6���O�'k	�u�<�cg>t�����m�c�)�r%6�W�ix�C�S7u�`���ޖ{ߌ��ƐC��d�̏����ϟG�vo�=��S���@\6��K�S?�O�\��M�9V�b�D�{f�z>r�i��L���s!��$��W���m��|��&Z�U�`�t�������f�˟�\����[�gzgk�KΚ���@݇n:|�8'w���6�̛�a^�o��0u�D��G^Y�K�*�<�|����*�)k�-
���C"2�W��YB�N�(��4��f��-$9����$���zq1��AQ��5sy��1�����#eq��6/����~~~�G93V9�5��.�&g�z�K��,�)VR���'jb�ݮR�� �:�g7jc4�$}$�j�!�"����������Q�)(�5��r��e8�����7��L���(%��/��s&��?5���&�m�%�l�ͯσ`��sw��B��˵�I�@��� ��z�Nc�w��T*/��8�r~:Oҿq�5�Lr��Tj�qɼ�~H%��lK��9p`��l������q��&)5Co}-1��B����pA�F&=1�����e}5o��'���Vt�1���IeV"��i������?��Q�R?�i��"k~�"��O��֎���j]eZ����ix1%(��q���oBi������z�):�͵�P(E�ŕ2��qM;��j�h�fC4���H6����9�XS�;�.%�F�M@�\(f7�{�d�M�u�����~�tR���lv۰��p�<��w߿�� uk5z�BU>�Ј��U>���Ǆ&���2,`������d�Nۨ�y�tTv�ּ��w��e��pO�<�Ih�pIt�v:���o��Э� ��A�A���D��q����e���ȩ�8q�����z�A���T����o�2�Qo(�
@����$�����(��I���L�0T���٩�h�m-��a�2�}�ee���S7�-��4�#;�,Z�Wް#�ݔ�"0+�Ʀr�4|�qh�75��r�椃ɚ���"{^����2Z�
z���q�n�x�<�ыh�;[����;���FLq��D� ,>k|���ʎ	b�$��0�)�����?�LS��t�3�%��dlR2��Xn ^���-��$,�W����6�I�F�睜�Č�L��ۍ�\��`�Y�C_��<J���<��]a�I��U`��!T��9,3��l/�����0o�����(GQ��>o�^#�j|���Vѓ=��d>�d>u�v�^�q�$�$ܜ,�+c�vr�I�k}l>G�NFc~���vE�|�^�0�2p�yJ���C0��Ky���	8+?���U��nC�NLE.x�YX�3�����*��� 1�x�zS�׳0�2y�T�b
ё�t�_5l�D
3���3t�+�l�Ps��j}���J͋[�����T��;�C�*V�yw���|Z -�TU�S�c��W�K�\��f�Gұ3�A2:�����+�{�밄<{pY�|�"��|R��j�)П�\Q��7�S;�{M1�YlN��^���2��2�F�l�_��H��?�܍��y�OdR�>I.���ܰd�W���� <4�"7GYX.ư��M�*J�[1ftCj����5N��8m�%8ZXel�2��\��`��R���k��u�rـj�����Jcp�W���m�'�H�0�%��N�*���9�]wY�Ηl6�wKc��bbp�9��E�k���i��H����\�f
I`թ]��A����)�����^`X�=_����`�����P`è-σ���~�V��Q,qh,~b���?{ں�0�o���$қO�Ëb&�$>ė�]FFV&��]UQU�u�BH���к�R�ˮ�����y�Ɓ��(7�\'׹ˬxD*�Z6�Ϝ���%�i�E��B��ۈ,�=��d=ujD�Y�"�l?5�"^l�����S�k�6l��KUa�`�v��e��D�,U�*UY�$v��F�e���O�ZI���&	�d�������S�'	��9���ʓOʑ~5����ށ3� ?_w��z�n
U1��I��Uv�A�k�z^^�M���"��x�~�($�P�*�̒7��Z�𧻓��W�q���I�^JT�ͲL�/?]h� 0�K��Rv�Z�!hkкI�9)�e�$��8�F�^$-}ܜ��H[�T�%��>���S�iy�/(��O��{�e%u�H.È�zl5�a��dz��ݩ6݉he���C����ʕ�82����xyl����r���U{�f����ܝwA��-0I᱾0b'	�mi��P*��F@
�Y��<�]�;]>�lN���C��ր���lwc��82W8�{��|�-��z/x���:�D�ޘ�}�' U����ǁ5u՟�_�p�� 6�ȴ��u�;�չ�w ԗ��
4���gx��Z���U�|�X�{zˮ�_��V���,�1#0�~����+��u�׆,��Ր�<�����+Eř`]q>FPN��̒Aw�
�;��+��u����Ԯt���V�cE@&4s�!dY���藽d�3q��[+�-S�F�{!�Aݥ�́�8[0}��?m�i�|&58r±U�uįx��P��ˑ�Pрi�-�N�|�:7I�JVkY���0H��I�}��Q���񬨿[��G�W�~T�������0Fueov��
�Cs%2B��
L��|U�]U.�S����O��r�I�N./�=0��3E���q����W��Fx��K �B�?�*� �hicfJ��G����_)֢�!L;���c�#��f����KK��=A�QeE�yz���'�h�P!)yL��I���pۿΰ���!.c��ܫ��?ͮ���\��X�s,��^�Z%_L&�
bU��	�,�Or�t�(��ϳ��B[ <a��sc��F���	?Vi���n�2��P��Us���www���     