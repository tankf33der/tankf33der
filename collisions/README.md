### Lets check djb's hash collisions:
* take english dictionary (~370K words)
* build collisions map for [djb2](http://www.cse.yorku.ca/~oz/hash.html) and [xxhash32](https://cyan4973.github.io/xxHash/)
* have fun.

#### djb:
```
 121541278: synaphea, joyful
 153103337: kilohm, broadened
 874715923: neurospora, heliotropes
1006249872: bedaggle, appling
1988349765: monologuist, colloquizing
2090194761: vivency, dram
2238710146: radioscopical, mordancy
2945051873: subgenera, stylist
2991272272: subgranularly, harassed
3315449116: tersulphuret, manageability
3547463122: stabilivolt, confisk
3940087062: mentioner, hetairas
4149284734: intracapsular, cunjah
```

#### xxhash:
```
 218679696: macrosporic, comparting
 257976272: estocada, bruits
 643471394: springboards, digitizing
 910362906: ootype, abilla
1262527594: institutionalists, hazardously
1345629155: scouriness, hogtied
1497718804: wikstroemia, interrelated
1531415768: idiogastra, dhurry
2121289022: welldoers, taikih
2243031061: mesoblastemic, coggers
2358510796: thereright, carlage
2882305929: nudophobia, comptly
4074852481: unability, hochheimer
4162098487: spadelike, hiccuped
```
#### 33 korovi:
djb2 algorithm is simple:
```
unsigned long
hash(unsigned char *str)
{
	unsigned long hash = 5381;
    int c;

	while (c = *str++)
    	hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
 
    return hash;
}
```
File [collisions.dat](https://git.envs.net/mpech/tankf33der/raw/branch/master/collisions/colliions.dat)
contains number of collisions for for number in range 1:255 against 33.


#### Links:
Right after publish I've found this good links, I put them here for science:
[stackexchange](https://softwareengineering.stackexchange.com/questions/49550/which-hashing-algorithm-is-best-for-uniqueness-and-speed)
,
[smhasher](https://github.com/rurban/smhasher/blob/master/doc/bernstein)
.
