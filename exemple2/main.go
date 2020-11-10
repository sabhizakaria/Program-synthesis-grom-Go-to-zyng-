package main

import (
	"fmt"
	"strconv"
)

// tableau de pixel à envoyer
var pixels = []uint16{63483, 62488, 1016, 31, 401, 31}

// calcul de la valeur de la couleur prédominante ansi que les filres de chaque pixel

func calcul(pIn chan uint16, cOut chan uint, pOut chan string) {

	//var valB, valV, valR, err1,err2,err3 int // valeur des champs couleur (4  bits)
	var cptB, cptV, cptR, cptPix uint8 // compteurs pour les couleurs et les pixels (14 bits)
	// Masks
	var maskR, maskV, maskB uint8
	// resultat intermediare RVB
	var resR, resV, resB string
	var pixel uint16 // pixel en entree (15 bits)
	var res uint

	// initialisations
	cptR = 0
	cptV = 0
	cptB = 0
	cptPix = 0
	num_pix := 0
	// boucle infinie
	for num_pix < len(pixels) {
		// reception du pixel
		pixel = <-pIn
		// convertion du pixel en format 16 bit
		pixel_tmp := fmt.Sprintf("%016b", pixel)
		//fmt.Printf("valeur initiale du pixel: %s \n", pixel_tmp)
		// decoupage du pixel

		valR, err1 := strconv.ParseInt(pixel_tmp[0:5], 2, 64)
		valV, err2 := strconv.ParseInt(pixel_tmp[6:11], 2, 64)
		// recuperer la valeur verte pour le calcul des masks
		valV_m, err3 := strconv.ParseInt(pixel_tmp[5:11], 2, 64)

		valB, err4 := strconv.ParseInt(pixel_tmp[11:16], 2, 64)
		if err1 != nil || err2 != nil || err3 != nil || err4 != nil {
			fmt.Println("Error Parsing pixel")
			return
		}

		// mise a jour des compteur et du pixel et les masks
		if valR > valV && valR > valB {
			cptR += 1
			maskR = 31 // rouge en 5 bits

		} else if valV > valB {
			cptV += 1
			maskV = 63 // Vert codé en 6 bit
		} else {
			cptB += 1
			maskB = 31 // Bleu codé en 5 bit
		}
		cptPix++
		// calcul des champs de couleur du pixel

		resR = fmt.Sprintf("%05b", uint8(valR)&maskR)
		resV = fmt.Sprintf("%06b", uint8(valV_m)&maskV)
		resB = fmt.Sprintf("%05b", uint8(valB)&maskB)
		pixel_str := resR + resV + resB
		pOut <- pixel_str

		// calcul et envoie du resultat  / remise a jour des cpt dans le cas ou c'est le dernier pixel à traiter

		if cptPix == uint8(len(pixels)) {
			if cptR > cptV && cptR > cptB {
				res = 2
			} else if cptV > cptB {
				res = 1
			} else {
				res = 0
			}
			cptR, cptV, cptB = 0, 0, 0
			fmt.Printf("Nombre de pixel traité(s): %d\n", cptPix)
			cOut <- res
		}
		num_pix++
	}
}

// affichage des pixel aprés avoir appliquer un filre
func aff_pix(pIn chan string, cOut chan int) {
	num_pix := 0
	for num_pix < len(pixels) {
		pixel := <-pIn
		fmt.Printf("Valeur du pixel reçue:    %s \n", pixel)
		fmt.Println()
		num_pix++
	}
	cOut <- 1
}

// affichage du code de la couleur prédominanate (7seg)
func affichage_couleur(cIn chan uint, cOut chan int) {
	var res uint = 0
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
}

func main() {
	// Declaration des canaux de communication (avec un canal de synchronisation)

	pIn := make(chan uint16)
	cOut := make(chan uint)
	pOut := make(chan string)
	var sync [2]chan int
	// allocation des tableau de canaux
	for i := range sync {
		sync[i] = make(chan int)
	}
	// lancement des goroutine ( execution parallel)
	go calcul(pIn, cOut, pOut)
	go affichage_couleur(cOut, sync[0])
	go aff_pix(pOut, sync[1])

	// envoie des pixel
	for i := range pixels {
		pIn <- pixels[i]
	}
	// attente de la fin d'execution des goroutine
	<-sync[1]
	<-sync[0]
}
