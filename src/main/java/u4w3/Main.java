package u4w3;

import static u4w3.Utils.*;
import u4w3.GeneraCatalogo;
import java.util.*;
import jakarta.persistence.EntityManager;
import u4w3.dao.ElementoCatalogoDAO;
import u4w3.dao.JPAUtil;
import u4w3.dao.PrestitoDAO;
import u4w3.dao.UtenteDAO;
import u4w3.entities.Libro;
import u4w3.entities.Rivista;
import u4w3.entities.Utente;
import u4w3.exception.ElementoNonTrovatoException;
import u4w3.exception.ErroreGenericoException;

import static u4w3.Utils.*;

public class Main {

    static EntityManager em = JPAUtil.getEntityManager();

    public static void main(String[] args) throws ElementoNonTrovatoException, ErroreGenericoException {

        Scanner scanner = new Scanner(System.in);

        boolean esci = false;

        // Cancella lo schermo all'inizializzazione
        _C();

        while (!esci) {
            _M();
            _Wn("\nSeleziona un'operazione: ");
            String scelta = (String) _LI("string", scanner);

            try {
                switch (scelta.toLowerCase()) {

                    // Aggiungi elemento
                    case "a" -> {

                        ElementoCatalogoDAO elementoCatalogoDAO = new ElementoCatalogoDAO(em);

                        _W("");
                        _R("-", 60);

                        String tipo = "";
                        while (!"L".equals(tipo) && !"R".equals(tipo)) {
                            _Wn("\nVuoi aggiungere un libro o una rivista? (L/R) : ");
                            tipo = ((String) _LI("string", scanner)).toUpperCase();

                            if (!"L".equals(tipo) && !"R".equals(tipo)) {
                                _W("\nTipo non valido.");
                            }
                        }

                        // Esegue la verifica se l'ISBN è già presente
                        String isbn = "";
                        boolean continua = false;
                        while (!continua) {
                            _Wn("\nInserisci ISBN: ");
                            isbn = (String) _LI("string", scanner);

                            if (isbn.length() < 5 || isbn.length() > 11) {
                                _W("\nL'ISBN deve essere compreso tra 5 e 11 caratteri.");
                                continue;
                            }
                            if (elementoCatalogoDAO.checkByISBN(isbn)) {
                                _W("\nISBN già presente.");
                                continue;
                            }
                            continua = true;
                        }

                        _Wn("\nInserisci titolo: ");
                        String titolo = (String) _LI("string", scanner);

                        _Wn("\nInserisci anno di pubblicazione: ");
                        int annoPubblicazione = (int) _LI("int", scanner);

                        _Wn("\nInserisci numero di pagine: ");
                        int numeroPagine = (int) _LI("int", scanner);

                        if ("L".equals(tipo)) {
                            _Wn("\nInserisci autore: ");
                            String autore = (String) _LI("string", scanner);

                            _Wn("\nInserisci genere: ");
                            String genere = (String) _LI("string", scanner);

                            Libro libro = new Libro();
                            libro.setCodiceISBN(isbn);
                            libro.setTitolo(titolo);
                            libro.setAnnoPubblicazione(annoPubblicazione);
                            libro.setNumeroPagine(numeroPagine);
                            libro.setAutore(autore);
                            libro.setGenere(genere);
                            libro.setTipo("Libro");

                            // Salvataggio del libro
                            ElementoCatalogoDAO libroDAO = new ElementoCatalogoDAO(em);
                            libroDAO.save(libro);
                            System.out.println("Libro salvato con ID: " + libro.getId() +
                                    " - Titolo: " + libro.getTitolo());

                        } else if ("R".equals(tipo)) {

                            int periodicita;
                            while (true) {
                                _Wn("\nInserisci periodicità: 1) SETTIMANALE 2) MENSILE 3) SEMESTRALE): ");
                                periodicita = (int) _LI("int", scanner);
                                if (periodicita < 1 || periodicita > 3) {
                                    _W("\nPeriodicità non valida.");
                                } else {
                                    break;
                                }
                            }

                            // Creazione di una nuova rivista
                            Rivista rivista = new Rivista();
                            // Imposta la periodicità della rivista
                            if (periodicita == 1) {
                                rivista.setPeriodicita(Rivista.Periodicita.SETTIMANALE);
                            } else if (periodicita == 2) {
                                rivista.setPeriodicita(Rivista.Periodicita.MENSILE);
                            } else {
                                rivista.setPeriodicita(Rivista.Periodicita.SEMESTRALE);
                            }
                            rivista.setCodiceISBN(isbn);
                            rivista.setTitolo(titolo);
                            rivista.setAnnoPubblicazione(annoPubblicazione);
                            rivista.setNumeroPagine(numeroPagine);
                            rivista.setTipo("Rivista");

                            // Salvataggio della rivista
                            ElementoCatalogoDAO rivistaDAO = new ElementoCatalogoDAO(em);
                            rivistaDAO.save(rivista);
                            System.out.println("Rivista salvata con ID: " + rivista.getId() +
                                    " - Titolo: " + rivista.getTitolo());
                        }

                        _W("");
                        _R("-", 132);
                        // Stampa l'elemento a conferma del corretto inserimento
                        _W(elementoCatalogoDAO.findByISBN(isbn).toString());

                        _W("");
                        _P();
                    }

                    // Ricerca per ISBN
                    case "b" -> {
                        _W("");
                        _R("-", 60);

                        String isbn = "";
                        boolean continua = false;
                        while (!continua) {
                            _Wn("\nInserisci ISBN: ");
                            isbn = (String) _LI("string", scanner);

                            if (isbn.length() < 5 || isbn.length() > 11) {
                                _W("\nL'ISBN deve essere compreso tra 5 e 11 caratteri.");
                                continue;
                            }
                            continua = true;
                        }

                        ElementoCatalogoDAO elementoCatalogoDAO = new ElementoCatalogoDAO(em);
                        _W("");
                        _R("-", 132);
                        // Stampa l'elemento e l'errore
                        _W(elementoCatalogoDAO.findByISBN(isbn).toString());

                        _W("");
                        _P();
                    }

                    // Ricerca per anno
                    case "c" -> {
                        _W("");
                        _R("-", 60);

                        _Wn("\nInserisci anno di pubblicazione: ");
                        int anno = (int) _LI("int", scanner);

                        ElementoCatalogoDAO elementoCatalogoDAO = new ElementoCatalogoDAO(em);
                        _W("");
                        _R("-", 132);
                        // Stampa l'elemento e l'errore
                        elementoCatalogoDAO.findByAnno(anno).forEach(System.out::println);

                        _W("");
                        _P();

                    }

                    case "d" -> {
                        _W("");
                        _R("-", 60);

                        _Wn("\nInserisci l'autore (anche parzialmente): ");
                        String autore = (String) _LI("string", scanner);

                        ElementoCatalogoDAO elementoCatalogoDAO = new ElementoCatalogoDAO(em);
                        _W("");
                        _R("-", 132);
                        // Stampa l'elemento e l'errore
                        elementoCatalogoDAO.findByAutore(autore).forEach(System.out::println);

                        _W("");
                        _P();
                    }

                    case "e" -> {
                        _W("");
                        _R("-", 60);

                        _Wn("\nInserisci il titolo (anche parzialmente): ");
                        String titolo = (String) _LI("string", scanner);

                        ElementoCatalogoDAO elementoCatalogoDAO = new ElementoCatalogoDAO(em);
                        _W("");
                        _R("-", 132);
                        // Stampa l'elemento e l'errore
                        elementoCatalogoDAO.findByTitolo(titolo).forEach(System.out::println);

                        _W("");
                        _P();
                    }

                    case "f" -> {

                        PrestitoDAO prestitoDAO = new PrestitoDAO(em);
                        UtenteDAO utenteDao = new UtenteDAO(em);

                        // Esegue la verifica se la tessera esiste
                        String tessera = "";
                        boolean continua = false;
                        while (!continua) {
                            _Wn("\nInserisci numero tessera: ");
                            tessera = (String) _LI("string", scanner);

                            if (tessera.length() != 10) {
                                _W("\nIl numero tessera deve essere di 10 numeri.");
                                continue;
                            }
                            if (!utenteDao.checkByTessera(tessera)) {
                                _W("\nUtente inesistente.");
                                continue;
                            }
                            continua = true;
                        }

                        _W("");
                        _R("-", 132);
                        // Stampa l'elemento e l'errore
                        prestitoDAO.findByNumeroTessera(tessera).forEach(System.out::println);
                        _W("");
                        _P();
                    }

                    case "g" -> {
                        PrestitoDAO prestitoDAO = new PrestitoDAO(em);
                        _W("");
                        _R("-", 132);
                        // Stampa l'elemento e l'errore
                        prestitoDAO.findPrestitiScadutiNonRestituiti().forEach(System.out::println);
                        _W("");
                        _P();
                    }

                    // Esci
                    case "z" -> {
                        _W("");
                        _R("-", 60);
                        esci = true;
                    }

                    // Rigenera il database
                    case "xxx" -> {
                        _W("");
                        _R("-", 60);

                        // resetta tutto il database
                        JPAUtil.svuotaDatabase(em);

                        GeneraCatalogo gc = new GeneraCatalogo();
                        // Ricrea elementi randomici
                        gc.CreaElementoCasuale("libro", 500);
                        gc.CreaElementoCasuale("rivista", 500);
                        gc.CreaUtenteCasuale(150);
                        gc.CreaPrestitoCasuale(1000);
                        _W("");
                        _P();

                    }

                    // Opzione non valida
                    default -> {
                        _W("\nOpzione non valida.");
                    }

                }
            } catch (ElementoNonTrovatoException e) {
                _W("");
                _R("!", 60);
                _W("");
                _W(" Errore \"404\": " + e.getMessage() + " ");
                _W("");
                _R("!", 60);
                _W("");
                _P();
            } catch (ErroreGenericoException e) {
                _W("");
                _R("!", 60);
                _W("");
                _W(" Errore GENERICO: " + e.getMessage() + " ");
                _W("");
                _R("!", 60);
                _W("");
                _P();
            }

        }

        scanner.close();
    }

}
