package main

import (
	"fmt"
	"strconv"
)

// tableau de pixel à envoyer
var pixels = []int{63488, 63488, 2016, 2016, 2016, 0}

func detection(cIn chan int, cOut chan int) {

	//var valB, valV, valR, err1,err2,err3 int // valeur des champs couleur (4  bits)
	var cptB, cptV, cptR, cptPix int // compteurs pour les couleurs et les pixels (14 bits)
	//var res byte                          //code resultat ( 1 bits)
	var pixel int // pixel en entree (15 bits)
	var res int

	// initialisations
	cptB = 0
	cptV = 0
	cptR = 0
	cptPix = 0
	// boucle infinie
	for {
		// reception du pixel
		pixel = <-cIn
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

		// mise a jour des compteur et du pixel
		if valR > valV && valR > valB {
			cptR += 1
		} else if valV > valB {
			cptV += 1
		} else {
			cptB += 1
		}
		cptPix++
		// calcul et envoie du resultat  / remise a jour des cpt dans le cas ou c'est le dernier pixel à traiter

		if cptPix == len(pixels) {
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
	}
}

func affichage_couleur(cIn chan int, cOut chan int) {
	var res int = 0
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

	cIn := make(chan int)
	cOut := make(chan int)
	c := make(chan int)
	// lancement des goroutine ( execution parallel)
	go detection(cIn, cOut)
	go affichage_couleur(cOut, c)

	// envoie des pixel
	for i := range pixels {
		cIn <- pixels[i]
	}
	// attente de la fin d'execution de affichage couleur
	<-c

}
