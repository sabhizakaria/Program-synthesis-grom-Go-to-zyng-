package main

import (
	"fmt"
	"strconv"
)

// tableau de pixel à envoyer
var pixels = [...]uint16{63483, 62488, 1016, 1016, 401, 1016, 31}

// calcul de la valeur de la couleur prédominante ansi que les filres de chaque pixel
func decoupage(pIn chan uint16, pOut chan uint16, valROut chan uint8, valVOut chan uint8, valBOut chan uint8) {
	for range pixels {
		// reception du pixel
		pixel := <-pIn
		// convertion du pixel en format 16 bit
		pixel_tmp := fmt.Sprintf("%016b", pixel)
		// decoupage du pixel

		valR, err1 := strconv.ParseInt(pixel_tmp[0:5], 2, 64)
		valV, err2 := strconv.ParseInt(pixel_tmp[6:11], 2, 64)
		valB, err3 := strconv.ParseInt(pixel_tmp[11:16], 2, 64)

		if err1 != nil || err2 != nil || err3 != nil {
			fmt.Println("Error Parsing pixel")
			return
		}
		// envoi des resultats et du pixel
		pOut <- pixel
		valROut <- uint8(valR)
		valVOut <- uint8(valV)
		valBOut <- uint8(valB)

	}

}

func conditions(valRIn chan uint8, valVIn chan uint8, valBIn chan uint8, cRout chan uint8, cVout chan uint8, cBout chan uint8) {
	var cB, cV, cR [len(pixels)]uint8 // compteurs pour les couleurs et les pixels (14 bits)
	var valR, valV, valB uint8        // valeurs des couleurs du pixel
	// initialisations

	// boucle d'envoi

	for num_pix := range pixels {
		valR = <-valRIn
		valV = <-valVIn
		valB = <-valBIn
		// mise a jour des compteur et du pixel et les masks
		if valR > valV && valR > valB {
			cR[num_pix] = 1

		} else if valV > valB {
			cV[num_pix] = 1
		} else {
			cB[num_pix] = 1
		}
	}
	// envoie des valeurs a la fonction calcul masque et detection

	for i := range pixels {
		cRout <- cR[i]
		cVout <- cV[i]
		cBout <- cB[i]
	}
	for i := range pixels {
		cRout <- cR[i]
		cVout <- cV[i]
		cBout <- cB[i]
	}
	// remise à zéro les conditions aprés l'envoie
	for j := range pixels {
		cR[j] = 0
		cV[j] = 0
		cB[j] = 0

	}

}

func calculMasques(cRIn chan uint8, cVIn chan uint8, cBIn chan uint8, maskROut chan uint8, maskVOut chan uint8, maskBOut chan uint8) {

	var cR, cV, cB uint8
	var maskR, maskV, maskB [len(pixels)]uint8
	// boucle de reception
	for num_pix := range pixels {
		cR = <-cRIn
		cV = <-cVIn
		cB = <-cBIn
		if cR == 1 {
			maskR[num_pix] = 31 // rouge en 5 bits
		}
		if cV == 1 {
			maskV[num_pix] = 63 // Vert codé en 6 bit
		}
		if cB == 1 {
			maskB[num_pix] = 31 // Bleu codé en 5 bit
		}
	}

	// boucle d'envoie
	for num_pix := range pixels {
		maskROut <- maskR[num_pix]
		maskVOut <- maskV[num_pix]
		maskBOut <- maskB[num_pix]
	}

}

func detection(cRIn chan uint8, cVIn chan uint8, cBIn chan uint8, res chan uint8) {
	var cR, cV, cB, cptR, cptV, cptB, res_seg uint8
	cptR, cptV, cptB = 0, 0, 0
	for num_pix := range pixels {

		cR = <-cRIn
		cV = <-cVIn
		cB = <-cBIn
		if cR == 1 {
			cptR++ // rouge en 5 bits

		}
		if cV == 1 {
			cptV++ // Vert codé en 6 bit
		}
		if cB == 1 {
			cptB++ // Bleu codé en 5 bit
		}

		if num_pix == len(pixels)-1 {
			if cptR > cptV && cptR > cptB {
				res_seg = 2
			} else if cptV > cptB {
				res_seg = 1
			} else {
				res_seg = 0
			}
			cptR, cptV, cptB, num_pix = 0, 0, 0, 0
			res <- res_seg
		}

	}

}

func memoirePixel(pIn chan uint16, pOut chan uint16) {
	var pixel uint16
	// tableau de pixel reçus
	var tab_pixel [len(pixels)]uint16
	// boucle de reception
	for num_pix := range pixels {
		pixel = <-pIn
		tab_pixel[num_pix] = pixel
	}
	// boucle d'envoie
	for num_pix := range pixels {
		pOut <- tab_pixel[num_pix]
	}
}

func calculPixel(pIn chan uint16, maskRIn chan uint8, maskVIn chan uint8, maskBIn chan uint8, pxResOut chan string) {
	// Masks
	var maskR, maskV, maskB uint8
	// rvaleur des couleurs du pixel apres le filtre
	var resR, resV, resB string
	// reception du pixel
	var pixel uint16                  // pixel en entree (15 bits)
	var pixel_str [len(pixels)]string // pixel resultant

	for num_pix := range pixels {
		pixel = <-pIn
		maskR = <-maskRIn
		maskV = <-maskVIn
		maskB = <-maskBIn

		// convertion du pixel en format 16 bit et decoupage

		pixel_tmp := fmt.Sprintf("%016b", pixel)
		valR, err1 := strconv.ParseInt(pixel_tmp[0:5], 2, 64)
		valV_m, err := strconv.ParseInt(pixel_tmp[5:11], 2, 64)
		valB, err3 := strconv.ParseInt(pixel_tmp[11:16], 2, 64)

		if err1 != nil || err != nil || err3 != nil {
			fmt.Println("Error Parsing pixel")
			return
		}
		// calcul du pixel resultat
		resR = fmt.Sprintf("%05b", uint8(valR)&maskR)
		resV = fmt.Sprintf("%06b", uint8(valV_m)&maskV)
		resB = fmt.Sprintf("%05b", uint8(valB)&maskB)
		// assemlage et envoie
		pixel_str[num_pix] = resR + resV + resB
	}

	// envoie du pixel
	for i := range pixels {
		pxResOut <- pixel_str[i]
	}
}

// affichage des pixel aprés avoir appliquer un filre

func aff_pix(pIn chan string, cOut chan int) {
	for range pixels {
		pixel := <-pIn
		fmt.Printf("Valeur du pixel reçue:    %s \n", pixel)
		fmt.Println()
	}
	cOut <- 1
}

// affichage du code de la couleur prédominanate (7seg)
func affichage_couleur(cIn chan uint8, cOut chan int) {
	var res uint8 = 0
	// reception du résultat
	res = <-cIn
	// affichage de la couleur dominante
	switch res {
	case 0:
		fmt.Printf("Valeur reçue : %d Couleur dominante ==> Bleu\n", res)
	case 1:
		fmt.Printf("Valeur reçue : %d Couleur dominante ==> Vert\n", res)
	case 2:
		fmt.Printf("Valeur reçue : %d Couleur dominante ==> Rouge\n", res)
	default:
		break
	}
	cOut <- 1
	fmt.Println("affichage_couleur OK")
}

func main() {
	// Declaration des canaux de communication (avec un canal de synchronisation)

	cOut := make(chan uint8)
	pOut := make(chan string)
	var valRGB [3]chan uint8
	var cndRGB [3]chan uint8
	var maskRGB [3]chan uint8
	var pIn [2]chan uint16
	var pMem [2]chan uint16
	var sync [2]chan int
	// allocation des tableau de canaux
	for i := range pIn {
		sync[i] = make(chan int)
		pIn[i] = make(chan uint16)
		pMem[i] = make(chan uint16)
	}
	for i := range valRGB {
		valRGB[i] = make(chan uint8)
		cndRGB[i] = make(chan uint8)
	}
	for i := range maskRGB {
		maskRGB[i] = make(chan uint8)
	}

	// lancement des goroutines ( execution parallele)
	go decoupage(pIn[0], pIn[1], valRGB[0], valRGB[1], valRGB[2])
	go conditions(valRGB[0], valRGB[1], valRGB[2], cndRGB[0], cndRGB[1], cndRGB[2])
	go calculMasques(cndRGB[0], cndRGB[1], cndRGB[2], maskRGB[0], maskRGB[1], maskRGB[2])
	go detection(cndRGB[0], cndRGB[1], cndRGB[2], cOut)
	go memoirePixel(pIn[1], pMem[0])
	go memoirePixel(pMem[0], pMem[1])
	go calculPixel(pMem[1], maskRGB[0], maskRGB[1], maskRGB[2], pOut)

	go affichage_couleur(cOut, sync[0])
	go aff_pix(pOut, sync[1])

	// envoie des pixel
	for i := range pixels {
		pIn[0] <- pixels[i]
	}

	fmt.Println("main OK")

	// attente de la fin d'execution des goroutine
	<-sync[0]
	<-sync[1]
}
