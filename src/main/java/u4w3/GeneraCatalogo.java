package u4w3;

import u4w3.entities.*;
import u4w3.exception.ElementoNonTrovatoException;
import u4w3.exception.ErroreGenericoException;
import u4w3.dao.*;
import com.github.javafaker.Faker;

import jakarta.persistence.EntityManager;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.TimeUnit;
import java.util.Random;

public class GeneraCatalogo {

    static EntityManager em = JPAUtil.getEntityManager();

    public void CreaElementoCasuale(String tipo, int numeroElementi) throws ErroreGenericoException {

        Random rndm = new Random();
        Faker faker = new Faker(Locale.of("it-IT"));

        switch (tipo.toLowerCase()) {
            case "libro":
                for (int i = 0; i < numeroElementi; i++) {
                    // Creazione di un nuovo libro
                    Libro libro = new Libro();
                    libro.setCodiceISBN(faker.code().isbn10());
                    libro.setTitolo(faker.book().title());
                    libro.setAnnoPubblicazione(faker.number().numberBetween(1900, 2023));
                    libro.setNumeroPagine(faker.number().numberBetween(100, 1000));
                    libro.setAutore(faker.book().author());
                    libro.setGenere(faker.book().genre());
                    libro.setTipo("Libro");

                    // Salvataggio del libro
                    ElementoCatalogoDAO libroDAO = new ElementoCatalogoDAO(em);
                    libroDAO.save(libro);
                    System.out.println("Libro salvato con ID: " + libro.getId() +
                            " - Titolo: " + libro.getTitolo());
                }
                break;

            case "rivista":
                for (int i = 0; i < numeroElementi; i++) {
                    // Creazione di una nuova rivista
                    Rivista rivista = new Rivista();
                    rivista.setCodiceISBN(faker.code().isbn10());
                    rivista.setTitolo(faker.book().title());
                    rivista.setAnnoPubblicazione(faker.number().numberBetween(1900, 2023));
                    rivista.setNumeroPagine(faker.number().numberBetween(10, 200));

                    // Imposta la periodicità della rivista
                    if (rndm.nextInt(3) == 0) {
                        rivista.setPeriodicita(Rivista.Periodicita.SETTIMANALE);
                    } else if (rndm.nextInt(3) == 1) {
                        rivista.setPeriodicita(Rivista.Periodicita.MENSILE);
                    } else {
                        rivista.setPeriodicita(Rivista.Periodicita.SEMESTRALE);
                    }

                    rivista.setTipo("Rivista");

                    // Salvataggio della rivista
                    ElementoCatalogoDAO rivistaDAO = new ElementoCatalogoDAO(em);
                    rivistaDAO.save(rivista);
                    System.out.println("Rivista salvata con ID: " + rivista.getId() +
                            " - Titolo: " + rivista.getTitolo());
                }
                break;

            default:
                System.out.println("Tipo non valido");
                break;
        }
    }

    public void CreaUtenteCasuale(int numeroElementi) throws ErroreGenericoException {

        // Inizializza Faker per generare dati casuali
        Faker faker = new Faker(Locale.of("it-IT"));

        // Creazione e salvataggio di 5 utenti casuali
        UtenteDAO utenteDAO = new UtenteDAO(em);
        for (int i = 0; i < numeroElementi; i++) {
            Utente utente = new Utente();
            utente.setNome(faker.name().firstName());
            utente.setCognome(faker.name().lastName());
            utente.setDataNascita(
                    faker.date().past(365 * 85, 365 * 18, TimeUnit.DAYS)
                            .toInstant().atZone(ZoneId.systemDefault()).toLocalDate());

            utente.setNumeroTessera(faker.number().digits(10));

            // Salvataggio dell'utente
            utenteDAO.save(utente);
            System.out.println("Utente salvato con ID: " + utente.getId() +
                    " - Nome: " + utente.getNome() +
                    " " + utente.getCognome());
        }

    }

    public void CreaPrestitoCasuale(int numeroElementi) throws ErroreGenericoException, ElementoNonTrovatoException {

        // Inizializza Faker per generare dati casuali
        Faker faker = new Faker(Locale.of("it-IT"));

        Random rndm = new Random();

        // Estrae la lista degli utenti
        UtenteDAO utenteDAO = new UtenteDAO(em);
        List<Utente> utenti = utenteDAO.findAll();

        // Estrae il catalogo
        ElementoCatalogoDAO elementoDAO = new ElementoCatalogoDAO(em);
        List<ElementoCatalogo> elementiCatalogo = elementoDAO.findAll();

        PrestitoDAO prestitoDAO = new PrestitoDAO(em);
        for (int i = 0; i < numeroElementi; i++) {

            // Estrae la lista dei prestiti
            List<Prestito> elencoPrestitiNonRestituiti = prestitoDAO.findPrestitiScadutiNonRestituiti();

            // Creazione di un nuovo prestito
            Prestito prestito = new Prestito();

            // Imposta la data di inizio prestito
            LocalDate dataInizioPrestito = faker.date().past(7 * 5, 0, TimeUnit.DAYS)
                    .toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

            // Imposta la data di inizio prestito
            prestito.setDataInizioPrestito(dataInizioPrestito);

            // Imposta la data di restituzione effettiva a null
            if (rndm.nextBoolean() == true) {
                // true = restituito
                // Ipotizziamo che il libro venga restituito entro 5 settimane
                // per computare anche eventuali ritardi
                prestito.setDataRestituzioneEffettiva(dataInizioPrestito.plusDays(rndm.nextInt(7 * 5)));
            } else {
                // false = non restituito
                prestito.setDataRestituzioneEffettiva(null);
            }

            // Restituisce un utente casuale
            Utente utenteCasuale = utenti.get(rndm.nextInt(utenti.size()));

            // Trova un libro non prestato
            ElementoCatalogo elementoCasuale = null;
            boolean elementoTrovato;
            do {
                // Restituisce un elemento casuale
                ElementoCatalogo elemento = elementiCatalogo.get(rndm.nextInt(elementiCatalogo.size()));

                // Verifica se l'elemento è già stato prestato
                elementoTrovato = elencoPrestitiNonRestituiti.stream()
                        .noneMatch(p -> p.getElementoPrestato().equals(elemento));

                if (elementoTrovato) {
                    elementoCasuale = elemento;
                }
            } while (!elementoTrovato);

            // Setta i valori del prestito
            prestito.setUtente(utenteCasuale);
            prestito.setElementoPrestato(elementoCasuale);

            // Salvataggio del prestito
            prestitoDAO.save(prestito);
            System.out.println("Prestito salvato con ID: " + prestito.getId() +
                    " - Utente: " + utenteCasuale.getNome() + " " + utenteCasuale.getCognome() +
                    " - Elemento: " + elementoCasuale.getTitolo());
        }
    }

    public void Genera() throws ErroreGenericoException, ElementoNonTrovatoException {

        // resetta tutto il database
        JPAUtil.svuotaDatabase(em);

        // Ricrea elementi randomici
        CreaElementoCasuale("libro", 500);
        CreaElementoCasuale("rivista", 500);
        CreaUtenteCasuale(150);
        CreaPrestitoCasuale(1000);

        em.close();
        JPAUtil.close();
    }
}